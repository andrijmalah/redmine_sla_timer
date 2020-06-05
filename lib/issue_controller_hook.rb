module RedmineSlaTimer
  module Hooks
    class SlaIssuesControllerHook < Redmine::Hook::ViewListener
      def controller_issues_new_before_save(context = {})
        issue = context[:issue]
        issue.build_sla_issue
      end

      def controller_issues_edit_before_save(context = {})
        issue = context[:issue]
        issue.sla_issue.reaction_time = 1  if issue.status.id > 1 && issue.sla_issue
      end
    end
  end
end
