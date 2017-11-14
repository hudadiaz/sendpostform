class MagicController < ApplicationController
  def index
    @mailbox = Mailbox.new
  end

  def create
    mailbox = Mailbox.find_by mailbox_params
    if mailbox && mailbox.request_magic_token
      redirect_to magic_path, notice: 'Check your email to continue.'
    else
      mailbox = Mailbox.new(mailbox_params)

      if mailbox.save
        set_current_mailbox mailbox
        redirect_to current_mailbox_path, notice: 'Mailbox was successfully created.'
      else
        redirect_to root_path, notice: @mailbox.errors
      end
    end
  end

  def login
    return head 400 unless magic_token
    mailbox = Mailbox.find_by magic_token: magic_token
    if mailbox && mailbox.magic_token_generated_at > 1.hour.ago
      set_current_mailbox mailbox
      return redirect_to current_mailbox_path, notice: 'Logged in successfully.'
    end
    redirect_to magic_path, notice: 'Invalid magic link.'
  end

  private

  def mailbox_params
    params.require(:mailbox).permit(:email)
  end

  def magic_token
    params.fetch(:token, nil)
  end
end
