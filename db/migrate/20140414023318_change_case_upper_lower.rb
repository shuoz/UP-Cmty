class ChangeCaseUpperLower < ActiveRecord::Migration
  def change
  	remove_reference :participants, :User, index: true
  	remove_reference :participants, :Event, index: true
  	add_reference :participants, :user, index: true
  	add_reference :participants, :event, index: true
  end
end
