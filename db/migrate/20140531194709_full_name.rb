class FullName < ActiveRecord::Migration
  def change
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	remove_column :users, :name, :string
  end
end
