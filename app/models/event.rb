class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  #attr_accessible :name, :start_time
  #def start_time
  #  event_start_time
  #end
end
