# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_04_183949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ip_logins", force: :cascade do |t|
    t.inet "ip", null: false
    t.bigint "user_id", null: false
    t.string "login", null: false
    t.index ["ip", "login"], name: "ip_users_login_idx", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "header", null: false
    t.string "content", null: false
    t.integer "marks_sum", default: 0, null: false
    t.integer "marks_count", default: 0, null: false
    t.float "average_mark", default: 0.0, null: false
    t.index ["average_mark"], name: "posts_average_mark_idx", order: :desc
    t.index ["user_id"], name: "posts_user_id_idx"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.index ["login"], name: "users_login_uniq_idx", unique: true
  end

  add_foreign_key "posts", "users", name: "posts_user_id_fkey"
end
