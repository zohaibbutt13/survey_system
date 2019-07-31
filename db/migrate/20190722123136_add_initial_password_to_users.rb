class AddInitialPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :initial_password, :string
  end
end
