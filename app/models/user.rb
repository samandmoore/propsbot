class User < ApplicationRecord
  devise :trackable, :omniauthable, :timeoutable, omniauth_providers: [:slack]

  has_many :props
  has_many :prop_recipients

  validates :slack_id, :slack_user, presence: true

  def self.from_omniauth(auth)
    user = find_or_initialize_by(slack_id: auth.info.user_id)
    user.full_name = auth.info.name
    user.slack_user = auth.info.user
    # TODO: avatar
    user.save

    user
  end
end
