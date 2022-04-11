class Event < ApplicationRecord
  validates :start_time_on, :end_time_on, presence: true
  validate :appropriate_start_and_end_dates
  
  belongs_to :task

  private

  def appropriate_start_and_end_dates
    if self.start_time_on && self.end_time_on
      errors.add(:start_time_on, I18n.t('views.errors.appropriate_start_and_end_dates')) if self.start_time_on >= self.end_time_on
    end
  end
end
