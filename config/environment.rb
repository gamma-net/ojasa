# Load the Rails application.
require File.expand_path('../application', __FILE__)

ENV['RECAPTCHA_PUBLIC_KEY'] = '6LcOfgkTAAAAAMNypZVMrQPcFYeVWt47kLs0qCNJ'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6LcOfgkTAAAAANIoHPMyKQIsGAxsnMGxwCOMSWHO'

# Initialize the Rails application.
Rails.application.initialize!
