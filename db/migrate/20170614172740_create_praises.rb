class CreatePraises < ActiveRecord::Migration[5.1]
  def change
    create_table :praises do |t|
      t.text :comment
      t.references :user
      
      t.timestamps
    end
  end
end
