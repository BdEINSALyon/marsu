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
end
