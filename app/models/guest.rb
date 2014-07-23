class Guest < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :participant
  validates :event_id, uniqueness: {scope: :user_id}
end
