require_dependency 'issue'

module IssuePatch
  extend ActiveSupport::Concern
  
  included do
    has_one :sla_issue, :dependent => :destroy

    accepts_nested_attributes_for :sla_issue

    def sla_reaction_time
      self.sla_issue.present? ? self.sla_issue.reaction_time : working_time_passed_in_hours(self.created_on)
    end

    def sla_timer
      l_hours_short(sla_reaction_time)
    end

    # def sla_timer_css_decoration
    #   font_color = project.sla_timer_settings.order(reaction_time: :desc).where(
    #     'reaction_time < ?', sla_reaction_time
    #   ).last.decoration
    #   " style=\"color:#{font_color};\" " if font_color
    # end

    def sla_timer_font_color
      font_color = project.sla_timer_settings.order(reaction_time: :desc).where(
        'reaction_time < ?', sla_reaction_time
      ).last.decoration
      font_color || '0'
    end
  end
end

Issue.send :include, IssuePatch
Issue.send :include, Shared

#<div class="value" style="color:#20d993;">60:35 h</div>