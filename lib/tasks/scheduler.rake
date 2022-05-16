namespace :scheduler do
  desc "This task is called by the Heroku scheduler add-on"
  task test_scheduler: :environment do
    puts "scheduler test"
    puts "it works."
  end

  task send_mails: :environment do
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
