class SessionController < ApplicationController
  def destroy
    session.delete :access_token
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def access_token
    params.fetch(:access_token, nil)
  end
end
