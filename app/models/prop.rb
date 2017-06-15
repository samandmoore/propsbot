class Prop < ApplicationRecord
  belongs_to :user
  has_many :recipients, class_name: 'PropRecipient'

  validates :comment, :user_id, presence: true

end
