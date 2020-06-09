# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'sla_projects', :to => 'sla_projects#index'
get 'projects/:project_id/sla_projects', :to => 'sla_projects#index'
