require_dependency 'issue'
module IssuePatch
  extend ActiveSupport::Concern
  
  included do
    has_one :sla_issue, :dependent => :destroy

    accepts_nested_attributes_for :sla_issue
  end  

  def sla_timer
    dif_time = Time.zone.now - created_on
    l_hours_short(dif_time / (60 * 60))
  end

end
Issue.send :include, IssuePatch

