class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.bigint :user_id
      t.bigint :friend_id
      t.integer  :ban, :limit => 1, :default => 0
      t.timestamps
    end
  end
end
