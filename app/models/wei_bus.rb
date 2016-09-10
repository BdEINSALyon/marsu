class WeiBus < ApplicationRecord

  has_many :students, through: :wei_registrations
  has_many :wei_registrations, -> {registered}
  belongs_to :wei

  scope :for_current_wei, -> {where(wei: Wei.current)}
  scope :not_full, -> {where('wei_registrations_count < seats')}

  default_scope { for_current_wei }

  validates :wei_registrations_count, inclusion: { in: -> (bungalow) {(0..(bungalow.seats))}}

end
