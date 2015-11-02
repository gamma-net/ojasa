class Customer < ActiveRecord::Base
  has_many :orders
  # belongs_to :address
  
  validates_presence_of :email
  validates_confirmation_of :confirm_password
  validates_uniqueness_of :email
  
  attr_accessor :confirm_password
  
  # def full_name
  #   "#{first_name} #{last_name}"
  # end
  
  class << self
    def verify?(email_username, unencrypted_password)
      return false unless customer = Customer.where(email: email_username).first || Customer.where(username: email_username).first
      customer.authenticate(unencrypted_password)
    end
  end
  
  def password=(unencrypted_password)
    unless unencrypted_password.blank?
      self[:password] = BCrypt::Password.create(Digest::MD5.hexdigest(unencrypted_password), cost: 4)
    end
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password) == Digest::MD5.hexdigest(unencrypted_password) ? self : false
  end
  
  def sanitize!
    self[:password] = '[FILTERED]'
    self
  end
  
  def full_address; "#{address} #{addressdetail}"; end
  def customer_address; address; end
end
