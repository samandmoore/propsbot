class DailyLimit < ApplicationRecord
  scope :today, -> { where(date: Time.zone.today) }

  def has_props_remaining?
    remaining > 0
  end
end
