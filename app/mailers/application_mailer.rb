class ApplicationMailer < ActionMailer::Base
  helper :services, :order_services
  default from: "no-reply@ojasa.co.id"
  layout 'mailer'
end
