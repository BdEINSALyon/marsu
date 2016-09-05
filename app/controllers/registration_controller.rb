class RegistrationController < ApplicationController
  def start
    if request.method_symbol == :get
      return
    end
    if request.method == :post
      @students = Students.includes('study_year').where(study_year: {year: [1,3]}).search_with params[:q]
    end
    if request.method == :put
      session[:student_id] = params[:student_id]
      redirect_to action: :questions
    end
  end

  def register
  end

  def questions
    @student = Student.find(session[:student_id])
  end

  def pay
    @student = Student.find(session[:student_id])
    p = params.permit(:method, :products)
    case @student.study_year.year
      when 1
        membership = Membership.find_by(price: 95.0)
        @student.paid_payments.create(payment_method: PaymentMethod.find_by_name(p[:method]), payable: membership)
        if p[:products] == 'VA+WEI'
          @student.paid_payments.create(payment_method: PaymentMethod.find_by_name(p[:method]), payable: membership)
          wei = @student.wei_registrations.last || @student.wei_registrations.create(paid: true)

        end
      when 3
        membership = Membership.find_by(price: 20.0)
      else
        membership = Membership.find_by(price: 20.0)
    end
  end

  def card
  end

  def details
  end
end
