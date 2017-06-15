class MessageProcessor

  attr_reader :text, :submitter_id

  def initialize(text, submitter_id, submitter_username)
    @text = text
    @submitter_id = submitter_id
    @submitter_username = submitter_username
  end

  def perform
    text_and_users = process_text
    if text_and_users[:slack_user_ids].count == 0
      return 'You have to give props to someone!'
    end
    ApplicationRecord.transaction do
      submitter = User.find_or_create_by(slack_id: submitter_id, username: submitter_username)

      prop = Prop.create(raw_comment: text, comment: text_and_users[:processed_text], user: submitter)

      recipients = text_and_users[:slack_user_ids].map do |slack_user_id|
        user = User.find_or_create_by(slack_id: slack_user_id)
        prop.recipients << PropRecipient.create(user: user)
      end
    end
    "You gave props to #{text_and_users[:slack_user_names].join(', ')}"
  end

  def process_text
    slack_user_ids = []
    slack_user_names = []
    processed_text = text.gsub(/<(?<sign>[?@#!]?)(?<value>.*?)>/) do |match|
      sign = $~[:sign]
      value = $~[:value]
      sides = value.split('|', 2)
      case sign
      when '@'
        slack_user_ids.push(sides[0])
        slack_user_names.push(sides[1])
        sides[1]
      end
    end
    {
      processed_text: processed_text,
      slack_user_ids: slack_user_ids,
      slack_user_names: slack_user_names
    }
  end
end
