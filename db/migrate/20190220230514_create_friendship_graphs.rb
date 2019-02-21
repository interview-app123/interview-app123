class CreateFriendshipGraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_graphs do |t|
      t.text :data
    end
  end
end
