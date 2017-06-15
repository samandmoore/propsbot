Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.timeout_in = 30.minutes

  config.omniauth :slack, ENV['2529038260.197872514549'], ENV['791954a099541bb192bb77cdf6f33b42'], scope: 'identity.basic', name: :sign_in_with_slack
end
