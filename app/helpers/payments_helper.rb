module PaymentsHelper

  def row_class(payment)
    return 'table-danger' unless payment.student
    'table-warning' if payment.refunded
  end

end
