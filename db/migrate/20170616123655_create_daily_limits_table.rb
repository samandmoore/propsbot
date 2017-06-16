class CreateDailyLimitsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_limits do |t|
      t.references :user, null: false, index: true
      t.date :date, null: false, index: true
      t.integer :remaining, null: false, default: 5
      t.index [:user_id, :date], unique: true
    end
  end
end
