class AddIndexAndNotNullToUserReplyToken < ActiveRecord::Migration
  def change
    change_column :users, :reply_token, :string, null: false

    add_index :users, :reply_token, unique: true
  end
end
