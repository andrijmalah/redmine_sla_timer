module ViewIssueHook
  class SlaTimerIssuesHook < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => 'issues/issue_details_bottom_hook'
    # render_on :view_issues_form_details_bottom, :partial => 'issues/issue_details_bottom_hook'
  end
end
