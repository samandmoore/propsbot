class MessageProcessor

  attr_reader :text, :submitter_id

  def initialize(text, submitter_id)
    @text = text
    @submitter_id = submitter_id
  end

  def perform
    text_and_users = process_text
    if text_and_users[:slack_user_ids].count == 0
      return 'You have to give praise to someone!'
    end
    ApplicationRecord.transaction do
      submitter = User.find_or_create_by(slack_id: submitter_id)

      praise = Praise.create(comment: text_and_users[:processed_text], user: submitter)

      recipients = text_and_users[:slack_user_ids].map do |slack_user_id|
        user = User.find_or_create_by(slack_id: slack_user_id)
        praise.recipients << PraiseRecipient.create(user: user)
      end
    end
    "You praised #{text_and_users[:slack_user_names].join(', ')}"
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
