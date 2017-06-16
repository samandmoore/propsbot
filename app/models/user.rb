class User < ApplicationRecord
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:slack]

  has_many :props
  has_many :prop_recipients

  validates :slack_id, presence: true

  delegate :full_name, :username, :as_mention, :avatar_url, to: :slack_user

  def self.from_omniauth(auth)
    puts auth.inspect
    find_or_create_by!(slack_id: auth.info.user_id)
  end

  def self.find_or_create_all_by_slack_ids(slack_ids)
    slack_ids.map do |slack_id|
      User.find_or_create_by!(slack_id: slack_id)
    end
  end

  private

  def slack_user
    @slack_user ||= SlackUser.new(slack_id)
  end
end
