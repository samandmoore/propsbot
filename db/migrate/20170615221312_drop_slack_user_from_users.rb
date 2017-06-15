class DropSlackUserFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :slack_user
  end
end
