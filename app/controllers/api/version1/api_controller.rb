class Api::Version1::ApiController < ApplicationController

  before_action :check_api_access

  def not_found
    render json: {error: 'Not Found', code: 404}, status: :not_found
  end

  def auth

  end

  private

  def current_app
    nil
  end

  def check_api_access
    if current_app.nil? and not (controller_name == 'api' and action_name == 'auth')
      render json: {error: 'Access Denied', code: 403}, status: :forbidden
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.env["Authorization"] # <= env
    header.gsub(pattern, '') if header && header.match(pattern)
  end

end