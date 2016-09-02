class WeiBus < ApplicationRecord

  has_many :students
  has_many :wei_registrations, -> {registered}
  belongs_to :wei

  scope :for_current_wei, -> {where(wei: Wei.current)}
  default_scope { for_current_wei }

  validate :not_full

  # Check ratio between m and w students

  private
  def not_full
    if students.length > seats
      errors.add(:students, 'sont trops nombreux dans ce bus, on ne peux pas le tolérer!')
    end
  end

end
