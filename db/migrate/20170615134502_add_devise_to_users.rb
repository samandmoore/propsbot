class AddDeviseToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      t.string :full_name
      t.string :slack_user
    end

    add_index :users, :slack_id, unique: true
    add_index :users, :slack_user, unique: true
  end
end
