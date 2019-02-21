class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :url
      t.string :full_url, unique: true
    end
  end
end
