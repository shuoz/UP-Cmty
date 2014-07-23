class ParticipantTimeJoined < ActiveRecord::Migration
  def change
  	add_column :participants, :timejoined, :datetime
  end
end
