class Event < ApplicationRecord
  validates :start_time_on, :end_time_on, presence: true
  
  belongs_to :task
end
