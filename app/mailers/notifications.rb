class Notifications < ActionMailer::Base
  default from: "admin@socialcalendar.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_comment.subject
  #
  def new_comment(comment)
    @greeting = "Hey there"
    @id = comment.id
    @commenter = comment.user.name

    mail to: comment.event.user.email
  end
end
