class SlaTimerWorkSchedule < ActiveRecord::Base
  belongs_to :project

  def days_time
    JSON.parse self[:days_time].gsub('=>', ':')
  end
end
