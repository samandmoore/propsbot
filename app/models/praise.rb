class Praise < ApplicationRecord
  belongs_to :user
  has_many :recipients, class_name: 'PraiseRecipient'

  validates :comment, :user_id, presence: true

end
