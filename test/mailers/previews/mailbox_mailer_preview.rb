# Preview all emails at http://localhost:3000/rails/mailers/mailbox_mailer
class MailboxMailerPreview < ActionMailer::Preview
  def confirmation_email
    MailboxMailer.confirmation_email Mailbox.first
  end
  
  def reset_token_email
    MailboxMailer.reset_token_email Mailbox.first
  end
end
