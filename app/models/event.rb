class Event < ApplicationRecord
  include ActionView::Helpers::TextHelper

  serialize :occurence_rule, Hash

  has_many :occurrences, dependent: :destroy

  belongs_to :reference, polymorphic: true, optional: true

  scope :system_generated, -> { where(system_generated: true) }

  scope :custom, -> { where(system_generated: [false, nil]) }

  after_save :create_custom_event_occurrences, :custom?

  before_save do
    unless custom?
      schedule.add_recurrence_rule(IceCube::Rule.yearly)

      assign_attributes(occurence_rule: schedule.recurrence_rules.first.to_hash)
    end

    true
  end

  enum event_type: {
    birthday: 'birthday',
    work_anniversary: 'work_anniversary',
    custom: 'custom',
  }

  def occurence_rule=(value)
    if RecurringSelect.is_valid_rule?(value)
      super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
      super(nil)
    end
  end

  def schedule
    @schedule ||= IceCube::Schedule.new(start_at, end_time: end_at)
  end

  def occurence_rule_to_s
    IceCube::Rule.from_hash(occurence_rule).to_s
  end

  def get_default_caption
    if birthday?
      "Wish them a Happy Birthday 🎂"
    elsif work_anniversary?
      year_count = Date.today.year - reference.doj.year
      "Successfully completed #{pluralize(year_count, 'year')} with Kiprosh 🙌"
    end
  end

  def schedule_with_rule
    schedule.add_recurrence_rule(
      IceCube::Rule.from_hash(occurence_rule)
    )

    schedule
  end

  def next_occurrence_this_year
    schedule_with_rule.occurrences_between(
      Time.now,
      Time.now.end_of_year
    ).last&.to_datetime
  end

  def create_system_occurence
    return unless system_generated?
    return unless next_occurrence_this_year

    occurrences.create(
      title: name,
      start_at: next_occurrence_this_year.beginning_of_day,
      end_at: next_occurrence_this_year.end_of_day,
      caption: get_default_caption
    )
  end

  def create_custom_event_occurrences
    return if system_generated?

    occurrences.destroy_all

    schedule_with_rule.occurrences_between(start_at, end_at).each_with_index do |date, index|
      occurrences.create(
        title: name,
        start_at: start_at.beginning_of_day,
        end_at: end_at.end_of_day,
        caption: "#{(index+1).ordinalize} occurrence"
      )
    end
  end
end
