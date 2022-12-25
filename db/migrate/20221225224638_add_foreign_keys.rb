class AddForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :sessions, :users
    add_foreign_key :tweets, :users
  end
end
