class ChangeEventDateFormat < ActiveRecord::Migration
  def change
  	remove_column :events, :month, :integer
  	remove_column :events, :day, :integer
  	remove_column :events, :year, :integer
  	add_column :events, :dayandtime, :datetime
  end
end
