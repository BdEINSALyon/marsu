class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_or_create_by email: request.env["omniauth.auth"].info.email do |user|
      pass = user.password = Devise.friendly_token
      user.password_confirmation = pass
    end

    @user.update azure_token: request.env["omniauth.auth"].credentials.token



    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Microsoft") if is_navigational_format?
    end
  end

  def failure
    redirect_to root_path
  end
end