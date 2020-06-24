#

resources :projects do
  resources :sla_timer_settings, :only => [:create, :update, :destroy]
end

match 'projects/:project_id/issues_sla_timer_update', to: 'issues#sla_timer_update', :via => :get, :as => 'issues_sla_timer_update'
