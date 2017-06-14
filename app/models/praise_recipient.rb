class PraiseRecipient < ApplicationRecord
  belongs_to :user
  belongs_to :praise

  validates :user_id, :praise_id, presence: true
end
