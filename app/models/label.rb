class Label < ApplicationRecord
  validates :genre, presence: true, length: { maximum: 10 }

  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
end
