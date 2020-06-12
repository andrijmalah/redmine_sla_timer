require 'redmine'

Redmine::Plugin.register :redmine_sla_timer do
  name 'Sla Timer plugin'
  author 'Andriy Malakhivskyy'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :sla_timer do
    permission :edit_sla_timer_settings, { :sla_timer_settings => [:edit, :index] }
  end
end




Rails.application.config.to_prepare do
  require_dependency 'issue_path'
  require_dependency 'view_issue_hook'
  require_dependency 'issues_controller_hook'
  require_dependency 'shared'
  require_dependency 'issue_query_path'
  require_dependency 'sla_issues_helper'
  require_dependency 'projects_helper_path'
  require_dependency 'project_path'
  require_dependency 'settings_helper'
end
