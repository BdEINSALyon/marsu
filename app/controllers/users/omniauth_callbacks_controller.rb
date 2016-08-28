class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_oauth2

    @user = User.find_or_create_by email: request.env["omniauth.auth"].info.email do |user|
      pass = user.password = Devise.friendly_token
      user.password_confirmation = pass
    end

    # Clear permissions for a user who has not been logged since a long
    if @user.updated_at < (Rails.env.development? ? 2.minutes : 1.month)
      @user.roles = []
      @user.save
    end

    # Save access token
    @user.update azure_token: request.env["omniauth.auth"].credentials.token

    # Check if user is tenant admin
    begin
      r = RestClient.get("https://graph.microsoft.com/v1.0/me/memberOf", :Authorization => "Bearer #{@user.azure_token}")
      admin_groups = JSON.parse(r.body)['value'].select {|g| g['@odata.type']== '#microsoft.graph.directoryRole'}
      if admin_groups.length > 0 and admin_groups[0]['displayName'] == 'Company Administrator'
        @user.add_role 'admin'
      end
    rescue
      # ignored
    end

    # Retreive local known groups for permissions
    azure = AzureRole.all.pluck :azure_gid
    user_azure_groups = []

    # Ask to Azure if the user is in one of this groups
    azure.each_slice(20).to_a.each do |groups_to_check|
      begin
        r = RestClient.post "https://graph.microsoft.com/v1.0/me/checkMemberGroups",{groupIds:groups_to_check}.to_json, content_type: :json, :Authorization => "Bearer #{@user.azure_token}"
        # Store the response
        user_azure_groups = user_azure_groups + JSON.parse(r.body)['value']
      rescue => _
      end
    end

    # For each valid group found, add the permissions to the user
    AzureRole.where(azure_gid: user_azure_groups).each do |azure_role|
      azure_role.roles.each {|role| @user.add_role role unless role.empty?}
    end

    if @user.persisted? and @user.roles.count > 0
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Microsoft") if is_navigational_format?
    else
      flash[:error] = t('oauth.no_permissions')
      redirect_to :new_user_session
    end
  end

  def failure
    flash[:error] = t('oauth.failure')
    redirect_to :new_user_session
  end
end