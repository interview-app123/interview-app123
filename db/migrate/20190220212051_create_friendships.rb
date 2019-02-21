class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :member, index: true
      t.references :friend
    end

    add_index :friendships, [:member_id, :friend_id], unique: true
  end
end
