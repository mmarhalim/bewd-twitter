class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string "username"
      t.string "email"
      t.string "password"
      t.index ["username"]
      t.index ["password"]

      t.timestamps
    end
  end
end
