class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.index "login", name: "users_login_uniq_idx", unique: true
    end
  end
end
