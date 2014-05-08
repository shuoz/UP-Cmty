class AddNameOfAttrForFilepickerUrlToUser < ActiveRecord::Migration
  def change
  	remove_column :users, :avatar_file_name, :string
  	remove_column :users, :avatar_content_type, :string
  	remove_column :users, :avatar_file_size, :integer
  	remove_column :users, :avatar_updated_at, :datetime
  end

  def up
    add_column :users, :filepicker_url, :string
  end

  def down
    remove_column :users, :filepicker_url
  end
end
