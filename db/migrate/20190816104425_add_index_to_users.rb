class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, [:email, :company_id], unique: true
  end
end