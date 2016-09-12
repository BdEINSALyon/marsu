class Api::Version1::MembershipController < ApiController
  def index

  end

  def show
    code = params[:code].to_s
    @student = Card.find_by_code(code)&.student
    if @student.nil?

    else
      if @student.member?
        
      end
    end
  end
end