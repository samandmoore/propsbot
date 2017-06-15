class Bot < SlackRubyBot::Bot
  command 'say' do |client, data, match|
    client.say(channel: data.channel, text: match['expression'])
  end

  # Uncomment the following to disable the default commands
  # command 'hi', 'help', 'about' do
  # end

  match /to (.+) for (.+)/ do |client, data, match|
    PropsToCommand.new(client, data, match).perform
  end
end
