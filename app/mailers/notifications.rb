class Notifications < ActionMailer::Base
  default from: "admin@penncommunity.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_comment.subject
  # 

  def new_event(event)
    @greeting = "New Event"
    @id = event.id

    mail(to: event.user.email, subject: 'You Created a New Event')
  end

  def event_reminder(event)
    #@time = event.dayandtime
    @id = event.id
    #event.reflect_on_all_associations(:belongs_to)
    
    @@counter = 0
    @participants = Participant.order(timejoined: :asc)
    #@guests = Guest.order(created_at: :asc)
    @event_members = []
    
    @participants.each do |participant|
      if participant.event.id == event.id
        if @@counter < event.maxpeople
          @event_members.push(participant.user.email)
          @@counter += 1
        end
      end
    end

    #@participants.each do |participant|
    #    @guests.each do |guest|
    #      if participant.event.id == event.id and guest.event.id == event.id
    #        if guest.created_at < participant.timejoined and guest.listed != 1
    #          if @@counter < event.maxpeople
    #            @event_members.push(guest.user.email)
    #          end
    #          guest.listed = 1
    #          @@counter += 1
    #        end
    #      end
    #      if @@counter < event.maxpeople
    #        @event_members.push(participant.user.email)
    #      end
    #      @@counter += 1
    #    end
    #end

    #@guests.each do |guest|
    #  if guest.event.id == event.id
    #    if guest.listed != 1
    #      if @@counter < event.maxpeople
    #        @event_members.push(guest.user.email)
    #        @@counter += 1
    #      else
    #        @@counter += 1
    #      end
    #    end
    #  end
    #end

    mail(to: @event_members, subject: 'Event Reminder')
    #mail(to: "shuoz@wharton.upenn.edu", subject: 'Event Reminder')
  end

 def new_comment(comment)
    @greeting = "New Comment"
    @id = comment.id
    @commenter = comment.user.firstname

    mail(to: comment.event.user.email, subject: 'You Created a New Comment')
  end

#  def contact
#    @message
#    mail to: "shuoz@wharton.upenn.edu"
#  end
end
