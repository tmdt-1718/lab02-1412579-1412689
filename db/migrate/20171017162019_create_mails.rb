class CreateMails < ActiveRecord::Migration[5.1]
  def change
    create_table :mails do |t|
      t.string :title
      t.bigint :user_send
      t.bigint :user_receive
      t.text :content
      t.integer  :isRead, :limit => 1
      t.timestamps
    end
  end
end
