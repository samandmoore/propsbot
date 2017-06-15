class AddRawCommentToPraise < ActiveRecord::Migration[5.1]
  def change
    add_column :praises, :raw_comment, :text
  end
end
