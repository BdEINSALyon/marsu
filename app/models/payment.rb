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
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
end
