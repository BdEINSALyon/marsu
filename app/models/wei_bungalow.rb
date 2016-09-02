class WeiBungalow < ApplicationRecord

  belongs_to :wei
  has_many :wei_registrations, -> {registered}
  has_many :students, through: :wei_registrations

  scope :for_current_wei, -> {where(wei: Wei.current)}
  default_scope { for_current_wei }

  # Check for mixte half of each

end
