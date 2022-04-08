class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :overview, presence: true, length: { maximum: 255 }

  enum status: {
    not_started: 0,
    underway: 1,
    completed: 2
  }
  
  has_many :task_items, dependent: :destroy
  accepts_nested_attributes_for :task_items, allow_destroy: true, reject_if: proc { |attributes| attributes['item'].blank? }

end
