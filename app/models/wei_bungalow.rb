class WeiBungalow < ApplicationRecord

  belongs_to :wei
  belongs_to :wei_bus
  has_many :wei_registrations, -> {registered}
  has_many :students, through: :wei_registrations

  scope :for_current_wei, -> {where(wei: Wei.current)}
  default_scope { for_current_wei }

  scope :not_full, -> {where('wei_registrations_count < seats')}
  scope :for_bus, -> (bus) {includes('wei_bus').where(wei_bus: bus)}

  validates :wei_registrations_count, inclusion: { in: -> (bungalow) {(0..(bungalow.seats))}}

  # Check for mixte half of each

end
