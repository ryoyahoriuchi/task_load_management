class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_task.subject
  #
  def sendmail_task(task)
    @task = task
    mail to: task.user.email, subject: 'Contact the task start date'
  end

  def sendmail_deadline_task(task)
    @task = task
    mail to: task.user.email, subject: 'Deadline contact'
  end
end
