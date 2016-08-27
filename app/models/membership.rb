class Membership < ApplicationRecord

  include GlobalID::Identification

  has_many :payments, as: :payable

  scope :active, -> {all}

end
