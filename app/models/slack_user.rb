class SlackUser
  attr_reader :slack_user_id

  def initialize(slack_user_id)
    @slack_user_id = slack_user_id
  end

  def full_name
    raw_slack_user.user.profile.real_name
  end

  def username
    raw_slack_user.user.name
  end

  def as_mention
    "<@#{slack_user_id}>"
  end

  private

  def raw_slack_user
   @raw_slack_user ||= client.users_info(user: slack_user_id)
  end

  def client
    @client ||= Slack::Web::Client.new
  end
end
