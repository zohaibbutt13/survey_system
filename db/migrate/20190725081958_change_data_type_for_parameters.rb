class ChangeDataTypeForParameters < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.change :parameters, :text
    end
  end
end