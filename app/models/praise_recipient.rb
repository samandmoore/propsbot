class PraiseRecipient < ApplicationRecord
  belongs_to :user
  belongs_to :praise
end
