class StatusUploadPolicy
  attr_reader :occurrence
  include ActionView::Helpers::DateHelper

  delegate :start_at, :end_at, :event, to: :occurrence

  def initialize(occurrence)
    @occurrence = occurrence
  end

  def upload_time_distance_in_words
    if upload_start_time.future?
      "Starts in #{distance_of_time_in_words(Time.zone.now, upload_end_time)}"
    elsif upload_end_time.future?
      "Expires in #{distance_of_time_in_words(Time.zone.now, upload_end_time)}"
    end
  end

  def upload_start_time
    if event.birthday? or event.work_anniversary?
      start_at.beginning_of_day.advance(days: -1).change(hour: 10)
    else
      start_at
    end
  end

  def upload_end_time
    if event.birthday? or event.work_anniversary?
      end_at.beginning_of_day.change(hour: 10)
    else
      end_at
    end
  end

  def allow_upload?
    Time.zone.now.between?(upload_start_time, upload_end_time)
  end

  def notifiable?
    Time.zone.now.between?(start_at, end_at)
  end
end
