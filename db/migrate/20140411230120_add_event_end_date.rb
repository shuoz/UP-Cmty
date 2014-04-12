class AddEventEndDate < ActiveRecord::Migration
  def change
  	add_column :events, :dayandtimeend, :datetime
  end
end
