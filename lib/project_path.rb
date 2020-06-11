require_dependency 'project'

module ProjectPatch
  extend ActiveSupport::Concern
  
  included do
    has_many :sla_timer_settings, :dependent => :destroy, :order => :reaction_time

    accepts_nested_attributes_for :sla_timer_settings, allow_destroy: true
  end
end 

Project.send :include, ProjectPatch