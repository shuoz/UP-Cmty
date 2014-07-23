class GuestBelongsToParticipant2 < ActiveRecord::Migration
  def self.up
  	add_column :guests, :participant_id, :integer
  	add_index :guests, :participant_id, :name => 'index_guests_on_participant_id'
  end

  def self.down
  	remove_column :guests, :participant_id, :integer
  end
end
