class RemovePassWordIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :password
    remove_index :users, :username
  end
end
