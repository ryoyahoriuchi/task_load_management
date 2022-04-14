class TaskItem < ApplicationRecord
  validates :item, :level, presence: true
  belongs_to :task
  has_many :memos, dependent: :destroy

  scope :create_sorted, -> { order(created_at: :asc)}
end
