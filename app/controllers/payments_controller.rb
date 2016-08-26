class PaymentsController < ApplicationController
  def create

  end

  def update
  end

  def index
    @payments = Payment.where(student_id:params[:student_id])
  end
end
