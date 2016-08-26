class Payment < ApplicationRecord
  belongs_to :payable, polymorphic: true
  belongs_to :payment_method
  belongs_to :student
  belongs_to :user

  scope :for_memberships, -> {where(payable_type: 'Membership')}
  scope :refunded, -> {where(refunded: true)}
  scope :not_refunded, -> {where(refunded: false)}

  validates_presence_of :student, :payment_method, :payable

  def membership?
    payable_type == 'Membership'
  end
end
