require 'redmine'

Redmine::Plugin.register :sla_timer do
  name 'Sla Timer plugin'
  author 'Andriy Malakhivskyy'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  #permission :polls, { :polls => [:index, :vote] }, :public => true
  project_module :sla_timer do
    # permission :view_polls, :polls => :index
    # permission :vote_polls, :polls => :vote
    permission :sla_timer, { :sla_projects => [:index] }
  
  end
  menu :project_menu, :contacts2, {:controller => 'contacts2', :action => 'index'}, :caption => 'contacts_title', :param => :project_id
# menu :project_menu, :contacts, {:controller => 'contacts', :action => 'index'}, :caption => :contacts_title, :param => :project_id
  menu :project_menu, :sla_timer_menu, { :controller => 'sla_projects', :action => 'index' }, :caption => 'SLA', :param => :project_id
end




Rails.application.config.to_prepare do
  require_dependency 'issue_path'
  require_dependency 'view_issue_hook'
  require_dependency 'issues_controller_hook'
  require_dependency 'shared'
  require_dependency 'issue_query_path'
  require_dependency 'sla_issues_helper'
  require_dependency 'projects_helper_path'

end
