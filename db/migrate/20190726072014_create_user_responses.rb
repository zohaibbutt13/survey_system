class CreateUserResponses < ActiveRecord::Migration
  def change
    create_table :user_responses do |t|
      t.references :users
      t.references :surveys
      t.string :email

      t.timestamps null: false
    end
  end
end
