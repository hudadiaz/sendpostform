module MailboxesHelper
  def mailbox_path
    session[:access_token].present? ? current_mailbox_path : new_mailbox_path
  end
end
