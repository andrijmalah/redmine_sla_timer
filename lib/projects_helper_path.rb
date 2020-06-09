require_dependency 'queries_helper'

# module ProjectsHelperPatch
#   extend ActiveSupport::Concern

  
#   class_methods do
#     unloadable
#     byebug
#     alias_method :project_settings_tabs_without_sla_timer, :project_settings_tabs
#     alias_method :project_settings_tabs, :project_settings_tabs_with_sla_timer
#     # alias_method :project_settings_tabs_without_contacts, :project_settings_tabs
#     # alias_method :project_settings_tabs, :project_settings_tabs_with_contacts
#   end

#   included do
#     def project_settings_tabs_with_sla_timer
#       tabs = project_settings_tabs_without_contacts

#       tabs.push(:name => 'sla_timer',
#                 :action => :manage_contacts,
#                 :partial => 'projects/contacts_settings',
#                 :label => 'SLA timer') if User.current.allowed_to?(:manage_contacts, @project)
#       byebug
#       tabs
#     end    
#   end


# end



module ProjectsHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable
      alias_method :project_settings_tabs_without_sla_timer, :project_settings_tabs
      alias_method :project_settings_tabs, :project_settings_tabs_with_sla_timer
    end
  end

  module InstanceMethods
    # include ContactsHelper

    def project_settings_tabs_with_sla_timer
      tabs = project_settings_tabs_without_sla_timer

      tabs.push(:name => 'sla_timer',
                :action => :manage_contacts,
                :partial => 'projects/sla_timer_settings',
                :label => :field_sla_timer) if User.current.allowed_to?(:manage_contacts, @project)
      tabs
    end
  end
end

# unless ProjectsHelper.included_modules.include?(ProjectsHelperPatch)
#   ProjectsHelper.send(:include, ProjectsHelperPatch)
# end
unless ProjectsHelper.included_modules.include?(ProjectsHelperPatch)
  ProjectsHelper.send :include, ProjectsHelperPatch
end  