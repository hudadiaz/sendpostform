class ResetController < ApplicationController
  def index
  end

  def create
    return head 400 unless email
    mailbox = Mailbox.find_by email: email
    if mailbox.request_reset_token
      redirect_to reset_path, notice: 'Reset Access Token request has been processed.'
    else
      redirect_to reset_path, notice: 'Something went wrong. Please try again later.'
    end
  end

  def apply
    return head 400 unless reset_token
    mailbox = Mailbox.find_by reset_token: reset_token
    if mailbox.reset_token_generated_at > 1.day.ago
      mailbox.generate_access_token
      if mailbox.save
        set_current_mailbox mailbox
        return redirect_to current_mailbox_path, notice: 'Access Token reset successfully.'
      end
    end
    redirect_to reset_path, notice: 'Reset token invalid.'
  end

  def api_key
    if current_mailbox.present?
      if current_mailbox.generate_api_key && current_mailbox.save
        return redirect_to current_mailbox_path, notice: 'API Key reset successfully.'
      end
    end
    redirect_to root_path, notice: 'Request invalid.'
  end

  def access_token
    if current_mailbox.present?
      if current_mailbox.generate_access_token && current_mailbox.save
        set_current_mailbox current_mailbox
        return redirect_to current_mailbox_path, notice: 'Access Token rreset successfully.'
      end
    end
    redirect_to root_path, notice: 'Request invalid.'
  end

  private

  def email
    params.fetch(:email, nil)
  end

  def reset_token
    params.fetch(:token, nil)
  end
end
