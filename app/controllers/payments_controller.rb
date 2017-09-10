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
      @payments = Payment.where(student_id: params[:student_id])
    else
      authorize! :export, Payment
      respond_to do |format|
        format.csv {send_data Payment.to_csv}
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

  def stats
    authorize! :stats, Payment
    today = Date.today.to_datetime
    end_of_today = Date.today.to_datetime + 23.hours + 59.minutes + 59.seconds
    @config = {
        start: today,
        end: end_of_today,
        tz: 'UTC+2'
    }
    if params.has_key? 'tz'
      @config[:tz] = params[:tz]
    end
    if params.has_key? 'start(1i)'
      @config[:start] = DateTime.new(params[:'start(1i)'].to_i, params[:'start(2i)'].to_i, params[:'start(3i)'].to_i, params[:'start(4i)'].to_i, params[:'start(5i)'].to_i, 0, @config[:tz])
    end
    if params.has_key? 'end(1i)'
      @config[:end] = DateTime.new(params[:'end(1i)'].to_i, params[:'end(2i)'].to_i, params[:'end(3i)'].to_i, params[:'end(4i)'].to_i, params[:'end(5i)'].to_i, 0, @config[:tz])
    end
    payments = Payment.where(created_at: @config[:start]..@config[:end], refunded: [nil, false])
    @data = {
        products: {
            weis: Payment.weis,
            memberships: Payment.memberships,
        },
        payments_methods: Payment.usable_methods,
        counts: {
            memberships: {},
            weis: {},
            payment_method: {}
        }
    }
    @data[:products].each do |name, elements|
      elements.each do |m|
        @data[:counts][name][m.id] = {
            total: payments.where(payable: m).count
        }
        @data[:payments_methods].each do |p|
          @data[:counts][name][m.id][p.id] = payments.where(payable: m, payment_method: p).count
        end
      end
    end
    print 'ah'
  end
end
