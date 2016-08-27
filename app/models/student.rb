class Student < ApplicationRecord

  belongs_to :study_year
  belongs_to :department
  has_many :payments
  has_many :paid_payments, -> {not_refunded}, class_name: 'Payment'
  has_many :memberships, through: :paid_payments, source: :payable, source_type: 'Membership'

  scope :members, -> {joins(:memberships).where('memberships.start_date <= ? AND memberships.end_date >= ?', Date.today, Date.today)}
  scope :non_members, -> {where.not(id: members)}

  validates_presence_of :first_name, :last_name, :gender, :email, :birthday
  validates_uniqueness_of :email
  validates_uniqueness_of :student_id
  validates_inclusion_of :gender, in: %w(M W)

  scope :minors, -> {where('birthday > ?', 18.years.ago)}

  def minor?
    birthday > 18.years.ago
  end

  def member?
    Student.members.include? self
  end

  def available_memberships
    Membership.where.not(id: memberships)
  end

  scope :search_with, -> (query) do
    request = all
    query.to_s.split(' ').each do |q|
      q = "%#{q}%"
      request = request.where(
          'first_name LIKE ? OR last_name LIKE ? OR student_id LIKE ?',
          q, q, q
      )
    end
    request
  end

  def name
    "#{first_name.capitalize} #{last_name.upcase}"
  end

end
