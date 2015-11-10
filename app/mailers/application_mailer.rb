class ApplicationMailer < ActionMailer::Base
  helper :services, :order_services, :accounts
  default from: "no-reply@ojasa.co.id"
  layout 'mailer'
end
