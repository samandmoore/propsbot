class Bot < SlackRubyBot::Bot
  command 'say' do |client, data, match|
    client.say(channel: data.channel, text: match['expression'])
  end

  # Uncomment the following to disable the default commands
  # command 'hi', 'help', 'about' do
  # end

  command 'to' do |client, data, match|
    PropsToCommand.call client, data, match
  end

  command 'leaderboard' do |client, data, match|
    leading_users = Prop.group(:user_id)
      .includes(:user)
      .select('user_id, count(1) as props_count')
      .order('props_count desc')
      .limit(10)

    leading_users.map do |

    client.web_client.chat_postMessage(channel: data.channel, text: <<~RESULT)
      *Leaderboard*
    RESULT
  end
end
