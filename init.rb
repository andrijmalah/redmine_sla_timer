require 'redmine'

Redmine::Plugin.register :sla_timer do
  name 'Sla Timer plugin'
  author 'Andriy Malakhivskyy'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
Rails.application.config.to_prepare do
  require_dependency 'issue_path'
  require_dependency 'issues_controller_hook'
  require_dependency 'shared'
end

# require 'redmine_helpdesk'