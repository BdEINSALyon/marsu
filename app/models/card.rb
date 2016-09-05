class Card < ApplicationRecord
  belongs_to :student
  validates_uniqueness_of :code, if: -> (card) {not card.code.empty?}
end
