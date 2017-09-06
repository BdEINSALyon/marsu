class PaymentsController < ApplicationController

  before_action :authenticate_user!

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
    if params[:student_id]
      @payments = Payment.where(student_id:params[:student_id])
    else
      authorize! :export, Payment
      respond_to do |format|
        format.csv { send_data Payment.to_csv }
      end
    end
  end

  def logs
    authorize! :logs, Payment
    @offset = params[:offset] || 0
    @limit = params[:limit] || 10
    @payments = Payment
                .order(:created_at)
                .reverse_order.offset(@offset).limit(@limit)
  end
end
