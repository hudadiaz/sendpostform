class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV['HOSTNAME']}"
  layout 'mailer'
  append_view_path Rails.root.join('app', 'views', 'mailers')
end
