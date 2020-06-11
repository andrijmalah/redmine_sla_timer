# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match 'projects/:project_id/sla_timer_settings', :to => 'sla_timer_settings#update', :via => [:put, :patch], as: :sla_timer_settings_update

resources :projects do
  resources :sla_timer_settings
  # , :only => [:new, :create]
end