require_dependency 'queries_helper'

module ProjectsHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      # unloadable
      alias_method :project_settings_tabs_without_sla_timer, :project_settings_tabs
      alias_method :project_settings_tabs, :project_settings_tabs_with_sla_timer
    end
  end

  module InstanceMethods
    def project_settings_tabs_with_sla_timer
      tabs = project_settings_tabs_without_sla_timer
      tabs.push(:name => 'sla_timer',
                :action => :edit_sla_timer_settings,
                :partial => 'projects/sla_timer_settings',
                :label => :field_sla_timer) if User.current.allowed_to?(:edit_sla_timer_settings, @project)
      tabs
    end

    def work_time
      if @project.sla_timer_work_schedule && @project.sla_timer_work_schedule.has_key?('work_time')

        # .days_time['work_time']
      else
        {'from' => '00.00', 'to' => '00.00'}
      end  
    end
  end
end

unless ProjectsHelper.included_modules.include?(ProjectsHelperPatch)
  ProjectsHelper.send :include, ProjectsHelperPatch
end  