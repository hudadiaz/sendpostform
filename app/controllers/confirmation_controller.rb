class ConfirmationController < ApplicationController
  def index
    confirmation_token = params.fetch(:token, nil)
    mailbox = Mailbox.find_by confirmation_token: confirmation_token
    if !mailbox.confirmed? && mailbox.confirm!
      if mailbox.confirmed?
        set_current_mailbox mailbox
        return redirect_to current_mailbox_path, notice: 'Mailbox successfully confirmed.'
      end
    end
    redirect_to current_mailbox_path, notice: 'Something went wrong. Try again later.'
  end

  def create
    if current_mailbox
      if current_mailbox.send_confirmation_email
        return redirect_to current_mailbox_path, notice: 'Confirmation email resent.'
      end
    end
    redirect_to current_mailbox_path, notice: 'Something went wrong. Try again later.'
  end
end
