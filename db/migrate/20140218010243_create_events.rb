class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :location
      t.integer :month
      t.integer :day
      t.integer :year
      t.integer :maxpeople
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
