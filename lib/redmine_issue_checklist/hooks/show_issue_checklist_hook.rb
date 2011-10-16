module RedmineIssueChecklist
  module Hooks
    class ShowIssueChecklistHook < Redmine::Hook::ViewListener     
      render_on :view_issues_show_description_bottom, :partial => "issues/issue_checklist_edit"
    end   
  end
end
