class MessageMailer < ApplicationMailer
  def message_notification_email message
    @message = message
    @mailbox = @message.mailbox
    @email = @mailbox.email
    mail(to: @email, subject: message_notification_subject(message))
  end

  def message_notification_subject message
    return message.subject if message.subject.present?
    I18n.t('email.subject')
  end
end
