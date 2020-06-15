module Shared
  SECONDS_IN_HOUR = 3600
  DAYS_OF_WEEK = %i[sun mon tue wed thu fri sat].freeze

  def time_in_hours(time)
    time.to_f / SECONDS_IN_HOUR
  end

  def working_time_passed_in_hours(from)
    return unless from

    time_in_hours(Biz.within(from, Time.current).in_seconds)
  end
end
