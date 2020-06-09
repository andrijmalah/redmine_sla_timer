require_dependency 'issue'

module IssuePatch
  extend ActiveSupport::Concern
  
  included do
    has_one :sla_issue, :dependent => :destroy

    accepts_nested_attributes_for :sla_issue
  end  

  def sla_reaction_time
    self.sla_issue.present? ? self.sla_issue.reaction_time : working_time_passed_in_hours(self.created_on)
  end

  def sla_timer
    l_hours_short(sla_reaction_time)
  end

end
Issue.send :include, IssuePatch
Issue.send :include, Shared

