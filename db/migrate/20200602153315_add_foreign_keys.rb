class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "posts", "users", name: "posts_user_id_fkey"
  end
end
