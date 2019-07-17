class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :user_id
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
