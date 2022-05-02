class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :overview, presence: true, length: { maximum: 255 }

  enum status: {
    not_started: 0,
    underway: 1,
    completed: 2
  }

  has_many :task_items, dependent: :destroy
  accepts_nested_attributes_for :task_items, reject_if: proc { |attributes| attributes['item'].blank? }, allow_destroy: true

  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  scope :with_labels, -> { joins(:labels) }
  scope :search_with_id, ->(labels) { where(labels: { id: labels }) }

  has_one :event, dependent: :destroy
  accepts_nested_attributes_for :event, allow_destroy: true

  belongs_to :user

  def self.schedule_check
    Task.all.each do |task|
      start_time = task.event.start_time_on
      end_time = task.event.end_time_on
      if start_time.year == Time.now.year && start_time.day == Time.now.day
        NoticeMailer.sendmail_task(task).deliver
      elsif end_time.year == Time.now.year && end_time.day == Time.now.day && task.status != "completed"
        NoticeMailer.sendmail_deadline_task(task).deliver
      end
    end
  end
end