class SlaTimerWorkSchedule < ActiveRecord::Base
  belongs_to :project

  def days_time
    JSON.parse self[:days_time].gsub('=>', ':')
  end

  def work_time_from=(h)
    dt = days_time
    dt['work_time']['from'] = (h.is_a?(String) ? (h.to_hours || h) : h)
    write_attribute :days_time, dt
  end

  def work_time_from
    days_time['work_time']['from'].to_f
  end

  def work_time_to=(h)
    dt = days_time
    dt['work_time']['to'] = (h.is_a?(String) ? (h.to_hours || h) : h)
    write_attribute :days_time, dt
  end

  def work_time_to
    days_time['work_time']['to'].to_f
  end

  def work_days=(days)
    dt = days_time
    dt['work_days'] = days
    write_attribute :days_time, dt
  end

  def work_days
    days_time['work_days']
  end
end
