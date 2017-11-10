class MailboxMailer < ApplicationMailer
  def confirmation_email mailbox
    @mailbox = mailbox
    @email = @mailbox.email
    mail(to: @email, subject: "Welcome to #{t('app.title')}")
  end

  def reset_token_email mailbox
    @mailbox = mailbox
    p @mailbox.reset_token
    @email = @mailbox.email
    mail(to: @email, subject: "Reset #{t('app.title')} Access Token")
  end
end
