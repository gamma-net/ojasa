module AccountsHelper
  def forgot_password_link(email)
    h = Customer.hashify(email)
    raw(reset_accounts_url(email: email, h: h))
  end
end
