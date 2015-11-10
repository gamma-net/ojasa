class Customer < ActiveRecord::Base
  has_many :orders
  # belongs_to :address
  
  validates_presence_of :email, :full_name, :phone, :address, unless: Proc.new {|c| c.reset_password? }
  validates_presence_of :password, :password_confirmation, if: Proc.new {|c| c.validate_password? }
  validates_confirmation_of :password
  validates_uniqueness_of :email
  # validates_presence_of :password_confirmation, :if => :password_changed?
  
  attr_accessor :password_confirmation, :reset_password
  
  # def full_name
  #   "#{first_name} #{last_name}"
  # end

  class << self
    def verify?(email_username, unencrypted_password)
      return false unless customer = Customer.where(email: email_username).first || Customer.where(username: email_username).first
      customer.authenticate(unencrypted_password)
    end
    
    def hashify(email)
      salt = 'oJasa'
      Digest::MD5.hexdigest(salt + email + salt)
    end
  end
  
  def password=(unencrypted_password)
    unless unencrypted_password.blank?
      self[:password] = BCrypt::Password.create(Digest::MD5.hexdigest(unencrypted_password), cost: 4)
    end
  end
  
  def password_confirmation=(unencrypted_password)
    unless unencrypted_password.blank?
      @password_confirmation = Digest::MD5.hexdigest(unencrypted_password)
    end
  end
    
  def password
    BCrypt::Password.new(self[:password]) if self[:password]
  end
  
  def authenticate(unencrypted_password)
    password == Digest::MD5.hexdigest(unencrypted_password) ? self : false
  end
  
  def sanitize!
    self.password = '[FILTERED]'
    self
  end
  
  def full_address; "#{address} #{addressdetail}"; end
  def customer_address; address; end
  
  protected
  
    def validate_password?
      new_record? || reset_password?
    end
    
    def reset_password?
      reset_password
    end
end
