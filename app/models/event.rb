class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  validates :title, presence: true
  validates :title, uniqueness: true

  scope :between, lambda {|start_time, end_time|
    {:conditions => ["? < dayandtime < ?", Event.format_date(start_time), Event.format_date(end_time)] }
  }

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :location => self.location,
      :maxpeople => self.maxpeople,
      :start => self.dayandtime, #.rfc822,
      :end => self.dayandtimeend, #.rfc822,
      #:allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id),
      #:color => "red"
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
    #Time.at(date_time.to_i).to_formatted_s(:db)
  end

  #attr_accessible :dayandtime
  #def start_time
  #	dayandtime
  #end
end
