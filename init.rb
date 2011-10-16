require 'redmine'
require 'dispatcher'

require 'redmine_issue_checklist/hooks/show_issue_checklist_hook'     
require 'redmine_issue_checklist/patches/issue_model_patch'     

Redmine::Plugin.register :redmine_issue_checklist do
  name 'Redmine Issue Checklist plugin'
  author 'Kirill Bezrukov'
  description 'This is a issue checklist plugin for Redmine'
  version '0.0.1'
  url 'http://redminecrm.com'
  author_url 'mailto:kirbez@redminecrm.com'
  
  project_module :issue_checklist do
    permission :add_checklists, :issue_checklists => [:new]
    permission :edit_checklists, :issue_checklists => [:delete, :done]
    permission :edit_own_checklists, :issue_checklists => [:delete, :done]
  end
  
end
