class Api::Version1::MembershipController < Api::Version1::ApiController
  def index

  end

  def show
    code = params[:code].to_s
    @student = Card.find_by_code(code)&.student
    if @student.nil? or @student.card != code
      not_found
    else
      render
    end
  end
end