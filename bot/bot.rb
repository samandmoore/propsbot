class Bot < SlackRubyBot::Bot
  command 'say' do |client, data, match|
    client.say(channel: data.channel, text: match['expression'])
  end

  # Uncomment the following to disable the default commands
  # command 'hi', 'help', 'about' do
  # end

  command 'to' do |client, data, match|
    PropsToCommand.new(client, data, match['expression']).perform
  end
end
