class PropRecipient < ApplicationRecord
  belongs_to :user
  belongs_to :prop

  validates :user_id, :prop_id, presence: true
end
