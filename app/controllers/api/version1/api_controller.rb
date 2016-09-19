class Api::Version1::ApiController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  before_action :check_api_access

  def parameter_missing
    render json: {error: 'Parameter Missing', code: 406}, status: :not_acceptable
  end

  def not_found
    render json: {error: 'Not Found', code: 404}, status: :not_found
  end

  def auth
    application = GlobalID::Locator.locate_signed params.require(:app_secret)
    not_found unless params.require(:app_id) == Digest::MD5.hexdigest(application.to_gid.to_s) or application.nil?
    @token = ApplicationToken.for_application application
  end

  private

  def current_app
    ApplicationToken.find_by_token(bearer_token)&.application
  end

  def check_api_access
    if current_app.nil? and not (controller_name == 'api' and action_name == 'auth')
      render json: {error: 'Access Denied', code: 403}, status: :forbidden
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"] # <= env
    header.gsub(pattern, '') if header && header.match(pattern)
  end

end