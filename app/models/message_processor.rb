class MessageProcessor

  attr_reader :text, :submitter_id, :submitter_username

  def initialize(text, submitter_id, submitter_username)
    @text = text
    @submitter_id = submitter_id
    @submitter_username = submitter_username
  end

  def perform
    text_and_users = process_text
    if text_and_users[:slack_ids_and_usernames].count == 0
      return 'You have to give props to someone!'
    end
    ApplicationRecord.transaction do
      submitter = User.create_with(username: submitter_username)
        .find_or_create_by(slack_id: submitter_id)
      prop = Prop.create(raw_comment: text, comment: text_and_users[:processed_text], user: submitter)

      recipients = text_and_users[:slack_ids_and_usernames].map do |slack_ids_and_usernames|
        user = User.create_with(username: slack_ids_and_usernames[:username])
          .find_or_create_by(slack_id: slack_ids_and_usernames[:id])
        prop.recipients << PropRecipient.create(user: user)
      end
    end
    final_string = "You gave props to "
    text_and_users[:slack_ids_and_usernames].each_with_index do |id_and_username, index|
      final_string << "#{id_and_username[:username]}"
      if index != text_and_users[:slack_ids_and_usernames].count - 1
        final_string << ", "
      end
    end
    final_string
  end

  def process_text
    slack_ids_and_usernames = [];
    processed_text = text.gsub(/<(?<sign>[?@#!]?)(?<value>.*?)>/) do |match|
      sign = $~[:sign]
      value = $~[:value]
      sides = value.split('|', 2)
      case sign
      when '@'
        slack_ids_and_usernames.push(id: sides[0], username: sides[1])
        sides[1]
      end
    end
    {
      processed_text: processed_text,
      slack_ids_and_usernames: slack_ids_and_usernames
    }
  end
end
