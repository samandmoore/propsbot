# MONKEYPATCH constant so that saying "props" or using the :props: emoji does not invoke the about command.
# This is happening because we configured props and :props: as bot aliases.
#
# References:
# https://github.com/slack-ruby/slack-ruby-bot/blob/master/lib/slack-ruby-bot/about.rb
module SlackRubyBot
  ABOUT = nil
end
