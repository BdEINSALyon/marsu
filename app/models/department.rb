class Department < ApplicationRecord

  has_many :students

  validates_presence_of :name, :code
  validates_uniqueness_of :code

  scope :active, -> {where(active:true)}

end
