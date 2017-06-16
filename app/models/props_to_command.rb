class PropsToCommand < SlackRubyBot::Commands::Base
  help do
    title 'to'
    desc 'Gives props to one or more people for something awesome they did.'
    long_desc '*Format*' \
      "\n" \
      ':props: to <one or more people> for <something awesome>' \
      "\n\n" \
      '*Examples*' \
      "\n" \
      ':props: to @alexbannon for bringing me into this world' \
      "\n" \
      ':props: to @lizderby and @caroline.lydon for the :beers:' \
      "\n" \
      "props to @erikahakanson for watching Roland"
  end

  def self.call(client, data, match)
    input = match[:expression]
    parts = input.sub(/ for /, '##SPLIT##').match /(.+)##SPLIT##(.+)/
    user_string = parts[1]
    props_string = parts[2]
    recipient_slack_ids = user_string.scan(/<@(?<value>.*?)>/).map(&:first)
    submitter = User.find_or_create_by!(slack_id: data.user)
    recipients = User.find_or_create_all_by_slack_ids(recipient_slack_ids)

    ApplicationRecord.transaction do
      prop = submitter.props.create!(raw_comment: input, comment: props_string)
      recipients.each do |recipient|
        prop.recipients << recipient
      end
    end

    client.say(channel: data.channel, text: <<~RESULT)
      #{submitter.as_mention} gave props to #{recipients.map(&:as_mention).join(', ')}

      > #{props_string}

      #{Emoji.random}
    RESULT
  end
end
