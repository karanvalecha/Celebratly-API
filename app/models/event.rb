class Event < ApplicationRecord
  serialize :occurence_rule, Hash

  belongs_to :reference, polymorphic: true

  scope :system_generated, -> { where(system_generated: true) }

  has_many :occurrences, dependent: :destroy

  before_save do
    if occurence_rule.empty?
      schedule.add_recurrence_rule(IceCube::Rule.yearly)

      assign_attributes(occurence_rule: schedule.recurrence_rules.first.to_hash)
    end

    true
  end

  def schedule
    @schedule ||= schedule= IceCube::Schedule.new(start_at)
  end

  def next_occurrence_this_year
    schedule.add_recurrence_rule(
      IceCube::Rule.from_hash(occurence_rule)
    )

    schedule.occurrences_between(
      Time.now,
      Time.now.end_of_year
    ).last&.to_datetime
  end

  def create_system_occurence
    return unless next_occurrence_this_year

    occurrences.create(
      title: "#{name} (celebrating #{Date.today.year - start_at.year} years)",
      start_at: next_occurrence_this_year.beginning_of_day,
      end_at: next_occurrence_this_year.end_of_day
    )
  end
end
