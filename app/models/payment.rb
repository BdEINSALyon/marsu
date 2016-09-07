class Payment < ApplicationRecord
  belongs_to :payable, polymorphic: true
  belongs_to :payment_method
  belongs_to :student
  belongs_to :user

  scope :for_memberships, -> {where(payable_type: 'Membership')}
  scope :refunded, -> {where(refunded: true)}
  scope :not_refunded, -> {where.not(id: refunded)}

  validates_presence_of :student, :payment_method, :payable

  def membership?
    payable_type == 'Membership'
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['id', 'student_email', 'student_name', 'student_id', 'payment_method', 'price', 'refunded']
      all.includes('payment_method').includes('student').includes('payable').each do |p|
        csv << [p.id, p.student.email, p.student.name, p.student.id, p.payment_method.name, p.payable.price, p.refunded]
      end
    end
  end
end
