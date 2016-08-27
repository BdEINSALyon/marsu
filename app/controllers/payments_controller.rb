class PaymentsController < ApplicationController
  def create
    @payment = Payment.new params.require(:payment).permit(:student_id, :payment_method_id)

    @payment.payable = GlobalID::Locator.locate_signed params.require(:payment).require(:payable_id)

    if current_user
      @payment.user = current_user
    end
    @success = @payment.save!

    respond_to do |f|
      f.js {}
      f.html {redirect_to student_path(@payment.student)}
      f.json {render action: :index}
    end
  end

  def update
    @payment = Payment.find(params[:id])
    update_payment = params.require(:payment).permit(:refunded)
    @payment.update! update_payment
    respond_to do |f|
      f.js {render action: :create}
      f.html {redirect_to student_path(@payment.student)}
      f.json {render action: :index}
    end
  end

  def index
    @payments = Payment.where(student_id:params[:student_id])
  end
end
