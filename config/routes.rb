#

resources :projects do
  resources :sla_timer_settings, :only => [:create, :update, :destroy]
end
