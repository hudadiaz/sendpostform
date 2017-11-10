class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_default_meta_tags

  def set_current_mailbox mailbox
    session[:access_token] = mailbox.access_token
  end
  helper_method :set_current_mailbox

  def current_mailbox
    @mailbox ||= Mailbox.find_by access_token: session[:access_token]
    unless @mailbox
      session.delete(:access_token)
      return redirect_to root_path, notice: 'Invalid session.'
    end
    @mailbox
  end
  helper_method :current_mailbox

  private

  def set_default_meta_tags
    set_meta_tags title: I18n.t('app.title'),
                  description: I18n.t('app.description')
  end
end
