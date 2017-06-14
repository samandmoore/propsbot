class Praise < ApplicationRecord
  belongs_to :user
  has_many :recipients, class_name: 'PraiseRecipient'

  validates :comment, presence: true

end
