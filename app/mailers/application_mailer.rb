class ApplicationMailer < ActionMailer::Base
  helper :application
  default from: ENV.fetch("DEFAULT_FROM_EMAIL", "someone@voicesofconsent.org")
  layout 'mailer'
end
