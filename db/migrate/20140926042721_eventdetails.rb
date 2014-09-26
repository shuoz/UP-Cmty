class Eventdetails < ActiveRecord::Migration
  def change
	add_column :events, :school, :string
	add_column :events, :attend, :integer
  end
end
