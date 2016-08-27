class PaymentMethod < ApplicationRecord
  has_many :payments
  scope :enabled, -> {where(enabled: true)}
end
