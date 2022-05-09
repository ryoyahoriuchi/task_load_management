# Preview all emails at http://localhost:3000/rails/mailers/notice_mailer
class NoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mailer/sendmail_start_task
  def sendmail_start_task
    NoticeMailer.sendmail_start_task
  end

end
