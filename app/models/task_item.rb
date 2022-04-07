class TaskItem < ApplicationRecord
  validates :item, :level, presence: true
  belongs_to :task
  has_many :memos, dependent: :destroy
end
