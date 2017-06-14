class Praise < ApplicationRecord
  belongs_to :user
  has_many :praise_recipients
end
