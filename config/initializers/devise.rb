Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.timeout_in = 30.minutes

  config.omniauth :slack, ENV['SLACK_OAUTH_APP_ID'], ENV['SLACK_OAUTH_APP_SECRET'], scope: 'identity.basic'
end
