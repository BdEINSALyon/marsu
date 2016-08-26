class Student < ApplicationRecord

  belongs_to :study_year
  belongs_to :department
  has_many :payments
  has_many :memberships, through: :payments, source: :payable, source_type: 'Membership'

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

end
