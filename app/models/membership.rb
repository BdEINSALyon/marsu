class Membership < ApplicationRecord

  include GlobalID::Identification

  has_many :payments, as: :payable

  scope :active, -> {where('memberships.start_date <= ? AND memberships.end_date >= ?', Date.today, Date.today)}

  def name_with_price
    "#{name} - #{price}0€"
  end

end
