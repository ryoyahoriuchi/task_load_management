class NoticeMailer < ApplicationMailer

  def sendmail_start_task(task)
    @task = task
    mail to: task.user.email, subject: I18n.t('mail.start_contact')
  end

  def sendmail_deadline_task(task)
    @task = task
    mail to: task.user.email, subject: I18n.t('mail.dead_contact')
  end
end
