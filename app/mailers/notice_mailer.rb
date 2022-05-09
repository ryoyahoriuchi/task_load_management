class NoticeMailer < ApplicationMailer

  def sendmail_start_task(task)
    @task = task
    mail to: task.user.email, subject: 'Contact the task start date'
  end

  def sendmail_deadline_task(task)
    @task = task
    mail to: task.user.email, subject: 'Deadline contact'
  end
end
