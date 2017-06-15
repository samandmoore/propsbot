class User < ApplicationRecord
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:slack]

  has_many :praises
  has_many :praise_recipients

  validates :slack_id, presence: true

  def self.from_omniauth(auth)
    user = find_or_initialize_by(slack_id: auth.info.user_id)
    user.full_name = auth.info.name
    user.slack_user = auth.info.user
    # TODO: avatar
    user.save

    user
  end
end
