require_dependency 'issue'

module IssuePatch
  extend ActiveSupport::Concern
  
  included do
    has_one :sla_issue, :dependent => :destroy

    accepts_nested_attributes_for :sla_issue

    def sla_reaction_time
      return unless project.project.enabled_module_names.include?(:sla_timer.to_s)
      return unless project.sla_timer_work_schedule && project.sla_timer_work_schedule.work_days.present?

      return sla_issue.reaction_time if sla_issue.present? && sla_issue.reaction_time.present?

      working_hours = {}
      project_work_schedule = project.sla_timer_work_schedule
      work_time = {
        format_hours(project_work_schedule.work_time_from) => format_hours(project_work_schedule.work_time_to)
      }
      project_work_schedule.work_days.each do |d|
        working_hours[WorkingHours::Config::DAYS_OF_WEEK[d]] = work_time
      end
      return if working_hours.empty?

      WorkingHours::Config.working_hours = working_hours
      working_time_passed_in_hours(created_on)
    end

    def sla_reaction_time_old
      sla_issue.present? ? sla_issue.reaction_time : working_time_passed_in_hours(created_on)
    end

    def sla_timer
      l_hours_short(sla_reaction_time)
    end

    def sla_timer_font_color
      setting = project.sla_timer_settings.order(reaction_time: :desc).where(
        'reaction_time < ?', sla_reaction_time
      ).last
      setting.present? && setting.decoration ? setting.decoration : 0
    end

    def format_hours(hours)
      return '' if hours.blank?

      h = hours.floor
      m = ((hours - h) * 60).round
      "%02d:%02d" % [h, m]
    end
  end
end

Issue.send :include, IssuePatch
Issue.send :include, Shared