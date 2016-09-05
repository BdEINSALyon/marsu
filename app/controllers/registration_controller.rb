class RegistrationController < ApplicationController

  before_action :authenticate_user!
  before_action :check_cdp

  def start
    if request.method_symbol == :get
      return
    end
    if request.method_symbol  == :post
      @students = Student.includes('study_year').where(study_years: {year: [1,2,3,4]}).search_with params[:q]
    end
    if request.method_symbol  == :put
      session[:student_id] = params[:student_id]
      redirect_to action: :questions
    end
  end

  def register
    if request.method_symbol == :get
      @student = Student.new study_year: StudyYear.find_by_year(1), department: Department.find_by_code('PC'), birthday: 18.years.ago
    else
      @student = Student.new(params.require(:student)
                                 .permit(:gender, :first_name, :last_name, :email, :card,
                                         :student_id, :department_id, :study_year_id, :phone, :birthday, :details))
      if @student.save
        session[:student_id] = @student.id
        redirect_to action: :questions
      end
    end
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
        if p[:products] == 'VA+WEI'
          @student.paid_payments.create(payment_method: PaymentMethod.find_by_name(p[:method]), payable: membership)
          wei = @student.wei_registrations.last || @student.wei_registrations.create
          wei.update paid: true
          if WeiRegistration.ranks[wei[:id]] <= 0
            wei.update status: 'registered'
          end
        end
      when 3
        membership = Membership.find_by(price: 20.0)
      else
        membership = Membership.find_by(price: 20.0)
    end
    @student.paid_payments.create(payment_method: PaymentMethod.find_by_name(p[:method]), payable: membership)
    redirect_to action: :card
  end

  def card
    @student = Student.find(session[:student_id])
    if request.method_symbol == :post
      @student.card= params[:student][:card]
      @success = @student.save
    end
  end

  def details
    @student = Student.find(session[:student_id])
    if request.method_symbol == :post
      session[:student_id] = nil
      redirect_to action: :start
    end
  end

  private
  def check_cdp
    authorize! :create, Student
    authorize! :create, Membership
    authorize! :create, WeiRegistration
  end
end
