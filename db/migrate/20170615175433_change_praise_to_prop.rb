class ChangePraiseToProp < ActiveRecord::Migration[5.1]
  def change
    remove_reference :praise_recipients, :praise
    rename_table :praises, :props
    add_reference :praise_recipients, :prop
    rename_table :praise_recipients, :prop_recipients
  end
end
