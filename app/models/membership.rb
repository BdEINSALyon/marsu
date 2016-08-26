class Membership < ApplicationRecord

  has_many :payments, as: :payable

end
