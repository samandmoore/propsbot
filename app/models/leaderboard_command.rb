class LeaderboardCommand < SlackRubyBot::Commands::Base
  help do
    title 'leaderboard'
    desc 'Lists the top 10 props givers of all time.'
  end

  def self.call(client, data, match)
    leading_users = Prop.group(:user_id)
      .includes(:user)
      .select('user_id, count(1) as props_count')
      .order('props_count desc')
      .limit(10)

    user_results = leading_users.map do |prop_user|
      user = prop_user.user
      "_#{user.full_name}_ has given #{prop_user.props_count} #{"prop".pluralize(prop_user.props_count)}"
    end

    client.web_client.chat_postMessage(channel: data.channel, text: <<~RESULT, as_user: true)
      *Leaderboard*
      #{user_results.join("\n")}
    RESULT
  end
end
