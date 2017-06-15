class PropsToCommand
  attr_reader :client, :data, :match

  def initialize(client, data, match)
    @client = client
    @data = data
    @match = match
  end

  def perform
    user_string = match[1]
    props_string = match[2]
    recipient_slack_ids = user_string.scan(/<@(?<value>.*?)>/).map(&:first)
    submitter = User.find_or_create_by!(slack_id: data.user)
    recipients = User.find_or_create_all_by_slack_ids(recipient_slack_ids)

    client.say(channel: data.channel, text: <<~RESULT)
      #{submitter.as_mention} gave props to #{recipients.map(&:as_mention).join(', ')}

      > #{props_string}

      :dancing_penguin: :dancing_penguin: :dancing_penguin:
    RESULT
  end
end
