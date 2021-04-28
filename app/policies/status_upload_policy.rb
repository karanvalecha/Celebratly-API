class StatusUploadPolicy
  attr_reader :occurrence

  def initialize(occurrence)
    @occurrence = occurrence
  end

  def allow_upload?
    if occurrence.event.birthday? or occurrence.event.work_anniversary?
      from = Time.now.yesterday.change(hour: 10) #10 AM yesterday
      to = Time.now.change(hour: 10) # 10 AM today

      occurrence.start_at.between?(from, to)
    else
      Time.now.between?(occurrence.start_at, occurrence.end_at)
    end
  end
end
