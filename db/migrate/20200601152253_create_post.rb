class CreatePost < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.bigint :user_id, null: false
      t.string :header, null: false
      t.string :content, null: false
      t.integer :marks_sum, null: false, default: 0
      t.integer :marks_count, null: false, default: 0
      t.float :average_mark, null: false, default: 0.0
      t.index :user_id, name: "posts_user_id_idx"
      t.index :average_mark, name: "posts_average_mark_idx", order: :desc
    end
  end
end
