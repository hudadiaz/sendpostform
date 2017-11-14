module ApplicationHelper
  def session_link
    if session[:access_token]
      active_link_to 'logout', session_path, class: 'nav-link text-danger', wrap_tag: :li, wrap_class: 'nav-item', method: :delete
    else
      active_link_to 'mailbox', magic_path, class: 'nav-link text-primary', wrap_tag: :li, wrap_class: 'nav-item'
    end
  end
end
