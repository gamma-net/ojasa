class MailingList < ActiveRecord::Base
  validates_presence_of :email

  after_create :send_email_confirmation

  protected

    def send_email_confirmation
    end
end
