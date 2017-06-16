class Bot < SlackRubyBot::Bot
  # Uncomment the following to disable the default commands
  # command 'hi', 'help', 'about' do
  # end

  command 'to' do |client, data, match|
    PropsToCommand.call client, data, match
  end

  command 'leaderboard' do |client, data, match|
    LeaderboardCommand.call client, data, match
  end
end
