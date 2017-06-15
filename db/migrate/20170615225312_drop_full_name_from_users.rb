class DropFullNameFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :full_name
  end
end
