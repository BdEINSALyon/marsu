class WeiRegistrationsController < ApplicationController
  before_action :set_wei_registration, only: [:show, :edit, :pay, :update, :destroy]

  # GET /wei_registrations
  # GET /wei_registrations.json
  # noinspection RailsChecklist01
  def index
    if params[:search].nil? or params[:search].empty?
      @wei_registrations = WeiRegistration.includes('student').all
    else
      # noinspection RailsChecklist01
      @wei_registrations = WeiRegistration.includes('student').where(student: Student.search_with(params[:search]))
    end
  end

  # GET /wei_registrations/1
  # GET /wei_registrations/1.json
  def show
  end

  # GET /wei_registrations/new
  # noinspection RailsChecklist01
  def new
    @wei_registration = WeiRegistration.new
    @students = Student.includes('study_year').where(study_year: StudyYear.where(year: 1)).where.not(id: @wei_registration.wei.students)
  end

  # POST /wei_registrations
  # POST /wei_registrations.json
  def create
    @wei_registration = WeiRegistration.new(wei_registration_params)
    @wei_registration.registration_by = Time.now
    @wei_registration.status = 'waiting'
    @wei_registration.paid = false

    respond_to do |format|
      if @wei_registration.save
        format.html { redirect_to @wei_registration, notice: 'Wei registration was successfully created.' }
        format.json { render :show, status: :created, location: @wei_registration }
      else
        format.html { render :new }
        format.json { render json: @wei_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wei_registrations/1
  # PATCH/PUT /wei_registrations/1.json
  def update
    respond_to do |format|
      if @wei_registration.update(wei_registration_params)
        format.html { redirect_to @wei_registration, notice: 'Wei registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @wei_registration }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @wei_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wei_registrations/1
  # DELETE /wei_registrations/1.json
  def destroy
    @wei_registration.destroy
    respond_to do |format|
      format.html { redirect_to wei_registrations_url, notice: 'Wei registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pay
    payment = Payment.new student: @wei_registration.student, payable: @wei_registration.wei
    payment.payment_method = PaymentMethod.find(params.require(:payment).permit(:payment_method_id)[:payment_method_id])
    if payment.save
      @wei_registration.update paid:true
    end
    respond_to do |f|
      f.js {render action: :update}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wei_registration
      @wei_registration = WeiRegistration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wei_registration_params
      params.require(:wei_registration).permit(:registration_by, :status, :wei_bungalow_id, :wei_bus_id, :student_id)
    end
end
