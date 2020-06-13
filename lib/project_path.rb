require_dependency 'project'

module ProjectPatch
  extend ActiveSupport::Concern

  included do
    has_many :sla_timer_settings, :dependent => :destroy, :order => :reaction_time
    has_one :sla_timer_work_schedule, :dependent => :destroy

    accepts_nested_attributes_for :sla_timer_settings, allow_destroy: true
    accepts_nested_attributes_for :sla_timer_work_schedule

  end
end

Project.send :include, ProjectPatch