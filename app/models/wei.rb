class Wei < ApplicationRecord

  has_many :wei_registrations
  has_many :wei_buses
  has_many :wei_bungalows

  has_many :validated_registrations, -> {registered}, class_name: 'WeiRegistration'
  has_many :waiting_registrations, -> {waiting}, class_name: 'WeiRegistration'

  has_many :students, through: :wei_registrations

  validates_presence_of :price, :seats, :date, :name

  def self.current
    @current = where(enabled: true).last if @current.nil?
    @current
  end

  def full?
    validated_registrations.count >= seats
  end

  def seats_left
    seats - validated_registrations.count
  end
end
