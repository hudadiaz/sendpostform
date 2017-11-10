class SessionController < ApplicationController
  def index
  end

  def create
    if mailbox = Mailbox.find_by(access_token: access_token)
      session[:access_token] = access_token
      redirect_to current_mailbox_path, notice: 'Logged in successfully.'
    else
      redirect_to session_login_path, notice: 'Access Token invalid.'
    end
  end

  def destroy
    session.delete :access_token
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def access_token
    params.fetch(:access_token, nil)
  end
end
