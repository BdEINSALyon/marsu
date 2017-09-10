class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  protect_from_forgery with: :exception
  after_filter :log_action

  def log_action
    if current_user
      LogEntry.create(
        user: current_user,
        ip: request.ip,
        params: params.as_json,
        controller: controller_name,
        action: action_name,
        path: request.path,
        method: request.method,
        status: response.status
      )
    end
  end

  private

  def after_sign_out_path_for(resource)
    # If it's admin
    tenant = ENV['AZURE_TENANT_ID']
    if resource == :user
      # Logout on Azure any tenant user
      "https://login.microsoftonline.com/#{tenant}/oauth2/v2.0/logout?post_logout_redirect_uri=#{root_url}"
    else
      root_path
    end
  end
end
