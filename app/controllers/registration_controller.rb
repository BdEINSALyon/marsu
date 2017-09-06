class RegistrationController < ApplicationController

  before_action :authenticate_user!
  before_action :check_cdp

  skip_before_action :verify_authenticity_token

  def start
    if request.method_symbol == :get
      session[:student_id] = nil
      return
    end
    if params.has_key? :search
      @students = Student.includes('study_year').where(study_years: {year: [1,2,3,4]}).search_with params[:search]
    end
    if params.has_key? :student_id
      session[:student_id] = params[:student_id]
      redirect_to action: :register
    end
  end

  def register
    if session[:student_id]
      if request.method_symbol == :get
        @student = Student.find_by_id session[:student_id]
      else
        @student = Student.find_by_id session[:student_id]
        if @student.update(params.require(:student)
                                   .permit(:gender, :first_name, :last_name, :email, :card,
                                           :student_id, :department_id, :study_year_id, :phone, :birthday, :details))
          session[:student_id] = @student.id
          redirect_to action: :questions
        end
      end
    else
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
  end

  def questions
    @student = Student.find(session[:student_id])
    if @student.member?
      redirect_to action: :card
    end
  end

  # noinspection RailsChecklist01
  def pay
    @student = Student.find(session[:student_id])
    p = params.permit(:method, :products)
    case @student.study_year.year
      when 1
        membership = @student.available_memberships.find_by(price: 95.0)
        if p[:products] == 'VA-WEI'
          wei = @student.wei_registrations.last || @student.wei_registrations.create
          Payment.new(payment_method: PaymentMethod.find_by_name(p[:method]), payable: wei.wei, student: @student).save!
          wei.update paid: true, status: 'waiting'
          unless wei.registration_by
            wei.update registration_by: Time.now
          end
        else
          wei = @student.wei_registrations.last
          unless wei.nil?
            wei.update status: wei.paid ? 'to_refund' : 'canceled'
          end
        end
      else
        membership = @student.available_memberships.find_by(price: 20.0)
    end
    if membership
      Payment.new(
        payment_method: PaymentMethod.find_by_name(p[:method]),
        payable: membership,
        student: @student
      ).save!
    end
    if @student.wei_registrations.last.status == 'waiting'
      redirect_to action: :wei_register
    else
      redirect_to action: :card
    end
  end

  # noinspection RailsChecklist01
  def wei_register
    @student = Student.find(session[:student_id])
    wei = @student.wei_registrations.last
    if wei.nil? || %(canceled to_refund registered).include?(wei.status)
      redirect_to action: :card
      return
    end
    if request.method_symbol == :post
      wei.update! params.require(:wei_registration).permit(:caution, :parental, :details, :medical_details)
      if WeiRegistration.ranks[wei[:id]] <= 0
        wei.update! status: 'registered'
      else
        wei.update! status: 'waiting'
      end
      redirect_to action: :card
    end
  end

  def card
    @student = Student.find(session[:student_id])
    if @student.cards.any?
      redirect_to action: :details
    end
    if request.method_symbol == :post
      @student.card= params[:student][:card]
      if @student.save
        redirect_to action: :details
      else
        flash[:error] = "Impossible d'enregistrer cette carte !"
      end

    end
  end

  def details
    @student = Student.find(session[:student_id])
    session[:student_id] = nil
  rescue ActiveRecord::RecordNotFound => _
    redirect_to action: :start
  end

  private
  def check_cdp
    authorize! :create, Student
    authorize! :create, Membership
    authorize! :create, WeiRegistration
  end
end
