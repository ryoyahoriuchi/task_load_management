class Memo < ApplicationRecord
  belongs_to :task_item
  validates :content, presence: true
end
