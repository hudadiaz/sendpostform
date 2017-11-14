class ResetController < ApplicationController
  def api_key
    if current_mailbox.present?
      if current_mailbox.generate_api_key && current_mailbox.save
        return redirect_to current_mailbox_path, notice: 'API Key magic successfully.'
      end
    end
    redirect_to root_path, notice: 'Request invalid.'
  end

  def access_token
    if current_mailbox.present?
      if current_mailbox.generate_access_token && current_mailbox.save
        set_current_mailbox current_mailbox
        return redirect_to current_mailbox_path, notice: 'Access Token rmagic successfully.'
      end
    end
    redirect_to root_path, notice: 'Request invalid.'
  end
end
