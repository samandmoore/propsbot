class CreatePraiseRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :praise_recipients do |t|
      t.references :user
      t.references :praise
      
      t.timestamps
    end
  end
end
