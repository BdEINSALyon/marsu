class Api::Version1::MembershipController < Api::Version1::ApiController
  def index

  end

  def show
    code = params[:code].to_s
    @student = Card.find_by_code(code)&.student
    if @student.nil? or @student.card != code
      @student = nil
      render status: :not_found, json: {error: 'No such student here!', code: 404}
    end
  end
end