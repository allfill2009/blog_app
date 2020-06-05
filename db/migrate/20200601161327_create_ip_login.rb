class CreateIpLogin < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_logins do |t|
      t.inet :ip, null: false
      t.bigint :user_id, null: false
      t.string :login, null: false
      t.index ["ip", "login"], name: "ip_users_login_idx", unique: true
    end
  end
end
