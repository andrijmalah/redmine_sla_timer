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

    def days_of_week_select(setting_values)
      setting_values = [] unless setting_values.is_a?(Array)
      days_of_week = (0..6).map { |d| [day_name(d), d.to_s] }
      setting  = :work_days
      options = { inline: true}
        content_tag('label', l(options[:label] || "setting_#{setting}")) +
          days_of_week.collect do |choice|
            text, value = choice
            content_tag(
              'label',
              check_box_tag(
                "project[sla_timer_work_schedule_attributes[work_days]][]",
                value,
                setting_values.include?(value),
                :id => nil
              ) + text.to_s,
              :class => (options[:inline] ? 'inline' : 'block')
              )
          end.join.html_safe
    end
  

  def days_of_week_select_old
    days_of_week = (0..6).map { |d| [day_name(d), d.to_s] }

    setting  = :work_days
    options = { inline: true}
      content_tag('label', l(options[:label] || "setting_#{setting}")) +
        days_of_week.collect do |choice|
          text, value = choice
          content_tag(
            'label',
            check_box_tag(
              "sla_timer_work_schedule[days_time][#{setting}][]",
              value,
              false,
              :id => nil
            ) + text.to_s,
            :class => (options[:inline] ? 'inline' : 'block')
            )
        end.join.html_safe
  end

    # def work_time
    #   if @project.sla_timer_work_schedule && @project.sla_timer_work_schedule.has_key?('work_time')

    #     # .days_time['work_time']
    #   else
    #     {'from' => '00.00', 'to' => '00.00'}
    #   end  
    # end
  end
end

unless ProjectsHelper.included_modules.include?(ProjectsHelperPatch)
  ProjectsHelper.send :include, ProjectsHelperPatch
end  