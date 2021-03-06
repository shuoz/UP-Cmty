class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :guests, :dependent => :destroy
  validates :event_id, uniqueness: {scope: :user_id}
end
