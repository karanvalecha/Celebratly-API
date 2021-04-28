desc "This task is called by the Heroku scheduler add-on"

task :send_occurence_invite_notifcation => :environment do
  OccurrenceInvitationJob.new.perform
end

task :send_wish_notification => :environment do
  SystemWisherJob.new.perform
  SendSlackNotification.new.perform
end