class TaskItem < ApplicationRecord
  validates :item, :level, presence: true
  belongs_to :task
end
