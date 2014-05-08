class AddCategoryAndTagline < ActiveRecord::Migration
  def change
  	add_column :events, :category, :string
  	add_column :users, :tagline, :string
  end
end
