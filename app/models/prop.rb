class Prop < ApplicationRecord
  belongs_to :user
  has_many :prop_recipients
  has_many :recipients, through: :prop_recipients, source: :user

  validates :comment, :user_id, presence: true
end
