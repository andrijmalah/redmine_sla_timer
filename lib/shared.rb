require 'working_hours'

module Shared
  SECONDS_IN_HOUR = 3600


  WorkingHours::Config.working_hours = {
    :tue => {'09:00' => '13:00', '14:00' => '18:00'},
    :wed => {'09:00' => '13:00', '14:00' => '18:00'},
    :thu => {'09:00' => '13:00', '14:00' => '18:00'},
    :fri => {'09:00' => '13:00', '14:00' => '18:00'},
    :mon => {'09:00' => '13:00', '14:00' => '18:00'}
  }
  
  # Configure timezone (uses activesupport, defaults to UTC)
  WorkingHours::Config.time_zone = Time.zone.name
  
  # Configure holidays
  WorkingHours::Config.holidays = [Date.new(2014, 12, 31)]

  def time_in_hours(time)
    time.to_f / SECONDS_IN_HOUR
  end

  def working_time_passed_in_hours(from)
    return unless from    

    time_in_hours(from.working_time_until(Time.zone.now))
  end

  # def time_substruct_in_hours(min, sub)
  #   (min - sub) / SECONDS_IN_HOUR
  # end

  # def time_passed_in_hours(since_time)
  #   time_in_hours(Time.zone.now - since_time)
  # end

end
