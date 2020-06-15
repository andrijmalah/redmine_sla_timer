require 'working_hours'

module Shared
  SECONDS_IN_HOUR = 3600

  WorkingHours::Config.working_hours = {
    :mon => {'09:00' => '18:00'},
    :tue => {'09:00' => '18:00'},
    :wed => {'09:00' => '18:00'},
    :thu => {'09:00' => '18:00'},
    :fri => {'09:00' => '18:00'}
  }

  # Configure timezone (uses activesupport, defaults to UTC)
  WorkingHours::Config.time_zone = Time.zone.name

  def time_in_hours(time)
    time.to_f / SECONDS_IN_HOUR
  end

  def working_time_passed_in_hours(from)
    return unless from

    time_in_hours(from.working_time_until(Time.zone.now))
  end
end
