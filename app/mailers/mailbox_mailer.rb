class MailboxMailer < ApplicationMailer
  def confirmation_email mailbox
    @mailbox = mailbox
    @email = @mailbox.email
    mail(to: @email, subject: "Welcome to #{t('app.title')}")
  end

  def magic_token_email mailbox
    @mailbox = mailbox
    p @mailbox.magic_token
    @email = @mailbox.email
    mail(to: @email, subject: "Magic link #{t('app.title')}")
  end
end
