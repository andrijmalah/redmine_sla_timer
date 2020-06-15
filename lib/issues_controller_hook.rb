class IssuesControllerHook < Redmine::Hook::ViewListener
  include Shared

  def controller_issues_new_before_save(context = {})
    # issue = context[:issue]
    # byebug

    # return unless issue.project.enabled_module_names.include?(:sla_timer.to_s)
    # issue.build_sla_issue unless issue.sla_issue.present?
    # issue.build_sla_issue if issue.project.enabled_module_names.include?(:sla_timer.to_s)
  end

  def controller_issues_edit_before_save(context = {})
    issue = context[:issue]
    return unless issue

    return unless issue.project.enabled_module_names.include?(:sla_timer.to_s)

    issue.build_sla_issue unless issue.sla_issue.present?
    if issue.status == issue.tracker.default_status
      issue.sla_issue.reaction_time = nil
      return
    end

    return if issue.status != issue.tracker.default_status && issue.sla_issue.reaction_time.present?

    issue.sla_issue.reaction_time = working_time_passed_in_hours(issue.created_on)
  end
end
