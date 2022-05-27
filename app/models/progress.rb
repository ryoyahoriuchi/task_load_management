class Progress < ApplicationRecord
  validates :percent, :item_number, presence: true
  belongs_to :task
end
