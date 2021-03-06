class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  has_many :guests, :dependent => :destroy
  validates :title, :location, presence: true
  #validates :title, uniqueness: true
  validates :title, length: {within: 1..30}
  validates :location, length: {within: 1..40}
  validates_time :dayandtimeend, :on_or_after => :dayandtime,
                                 :on_or_after_message => 'Event cannot end before it begins!'
  validates_date :dayandtimeend, :on_or_after => :dayandtime,
                                 :on_or_after_message => 'Event cannot end before it begins!'                            

  scope :between, lambda {|start_time, end_time|
    {:conditions => ["? < dayandtime < ?", Event.format_date(start_time), Event.format_date(end_time)] }
  }

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :category => self.category,
      :location => self.location,
      :maxpeople => self.maxpeople,
      :school => self.school,
      :attend => self.attend,
      :start => dayandtime,
      :end => dayandtimeend,
      :allDay => false,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id),
      :color => "#95001a"
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:long)
  end

  def self.reminder
    @events = Event.all
    #@events = Event.all(:conditions => ["dayandtime BETWEEN ? AND ?", Time.now.beginning_of_day, Time.now.end_of_day])
    #@events = Event.where(dayandtime.to_date == Time.now.to_date)
    @events = Event.order(dayandtime: :asc)
    @events.each do |event|
      if event.dayandtime.to_date == Time.now.to_date
        Notifications.event_reminder(event).deliver
      end
    end
  end

end
