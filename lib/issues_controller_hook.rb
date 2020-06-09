class IssuesControllerHook < Redmine::Hook::ViewListener
  include Shared

  def controller_issues_new_before_save(context = {})
    issue = context[:issue]
    issue.build_sla_issue
  end

  def controller_issues_edit_before_save(context = {})
    issue = context[:issue]
    return unless issue

    issue.build_sla_issue unless issue.sla_issue
    if issue.status != issue.tracker.default_status && issue.sla_issue.reaction_time.blank?
      issue.sla_issue.reaction_time = working_time_passed_in_hours(issue.created_on)
    end
  end
end
