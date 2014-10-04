class AddReplyTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :reply_token, :string
  end
end
