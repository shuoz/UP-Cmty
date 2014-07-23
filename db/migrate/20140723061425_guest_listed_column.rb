class GuestListedColumn < ActiveRecord::Migration
  def change
  	add_column :guests, :listed, :integer
  end
end
