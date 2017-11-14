module MailboxesHelper
  def mailbox_path
    session[:access_token].present? ? current_mailbox_path : magic_path
  end
end
