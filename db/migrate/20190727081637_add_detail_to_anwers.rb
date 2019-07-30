class AddDetailToAnwers < ActiveRecord::Migration
  def change
    add_column :answers, :detail, :text
  end
end
