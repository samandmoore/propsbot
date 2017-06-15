class AddConstraintsToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :username
    change_column_null :users, :slack_user, false
    change_column_null :users, :slack_id, false
  end
end
