class Wei < ApplicationRecord

  has_many :wei_registrations
  has_many :wei_buses
  has_many :wei_bungalows

  has_many :validated_registrations, -> {registered}, class_name: 'WeiRegistration'
  has_many :waiting_registrations, -> {registered}, class_name: 'WeiRegistration'

  has_many :students, through: :wei_registrations

  validates_presence_of :enabled, :price, :seats, :date, :name

  def self.current
    where(enabled: true).last
  end

end
