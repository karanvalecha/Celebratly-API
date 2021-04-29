desc "This task is called by the Heroku scheduler add-on"

task :send_occurence_invite_notifcation => :environment do
  OccurrenceInvitationJob.new.perform
end

task :compile_and_publish_video => :environment do
  Occurrence.all.select {|o| StatusUploadPolicy.new(o).notifiable? }.each do |occ|
    if true#StatusUploadPolicy.new(occ).upload_end_time.past?
      puts "Processing #{occ.title}"

      PublishVideoJob.perform_now(occ) unless occ.published_video_attachment
    end
  end
end
