class AddContentToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :content, :text
  end
end
