# Preview all emails at http://localhost:3000/rails/mailers/mail_mailer
class MessageMailerPreview < ActionMailer::Preview
  def message_notification_email
    MessageMailer.message_notification_email Message.last
  end
end
