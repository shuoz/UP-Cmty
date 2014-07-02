class Notifications < ActionMailer::Base
  default from: "admin@penncommunity.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_comment.subject
  #
  def new_comment(comment)
    @greeting = "Hey there"
    @id = comment.id
    @commenter = comment.user.firstname

    mail to: comment.event.user.email
  end

  def new_event(event)
    @greeting = "Hey there"
    @id = event.id

    mail to: event.user.email
  end

#  def contact
#    @message
#    mail to: "shuoz@wharton.upenn.edu"
#  end
end
