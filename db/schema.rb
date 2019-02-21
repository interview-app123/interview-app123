# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_20_230514) do

  create_table "friendship_graphs", force: :cascade do |t|
    t.text "data"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "member_id"
    t.integer "friend_id"
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["member_id", "friend_id"], name: "index_friendships_on_member_id_and_friend_id", unique: true
    t.index ["member_id"], name: "index_friendships_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "full_url"
    t.text "content"
  end

end
