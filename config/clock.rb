require 'clockwork'
include Clockwork
require_relative 'task_job'

require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)

module Clockwork
  every(1.days, 'Task.publish_check', at: '08:00') do
    Task.includes(:event).all.each do |task|
      start_time = task.event.start_time_on
      end_time = task.event.end_time_on
      if start_time.year == Time.now.year && start_time.day == Time.now.day
        NoticeMailer.sendmail_start_task(task).deliver
      elsif end_time.year == Time.now.year && end_time.day == Time.now.day && task.status != "completed"
        NoticeMailer.sendmail_deadline_task(task).deliver
      end
    end
  end
end

module Clockwork
  handler do |job|
    job.call
  end

  every(1.minutes, TaskJob.new)
end