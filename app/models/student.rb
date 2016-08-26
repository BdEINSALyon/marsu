class Student < ApplicationRecord

  belongs_to :study_year
  belongs_to :department

  validates_presence_of :first_name, :last_name, :gender, :email, :birthday
  validates_uniqueness_of :email
  validates_uniqueness_of :student_id
  validates_inclusion_of :gender, in: %w(M W)
  validates_inclusion_of :birthday, in: -> (student) {(1000.years.ago...10.years.ago)}

  scope :minors, -> {where('birthday > ?', 18.years.ago)}

  def minor?
    birthday > 18.years.ago
  end

end
