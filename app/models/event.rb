class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  validates :title, presence: true
  validates :title, uniqueness: true

  #attr_accessible :dayandtime
  #def start_time
  #	dayandtime
  #end
end
