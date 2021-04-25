# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# 
every 1.day, at: '10am' do
  runner "OccurrenceInvitationJob.new.perform_async"
  # , :output => 'log/development.log'
end

every 1.day, at: '11am' do
  runner "SystemWisherJob.new.perform_async"
  # , :output => 'log/development.log'
end

# Learn more: http://github.com/javan/whenever
