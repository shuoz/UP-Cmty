#desc "This task is called by the Heroku scheduler add-on"
#task :update_feed => :environment do
#  puts "Updating feed..."
#  NewsFeed.update
#  puts "done."
#end

task :reminder => :environment do
  Event.reminder
end
