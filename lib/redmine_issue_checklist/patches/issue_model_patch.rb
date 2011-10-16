require_dependency 'issue'  

module RedmineIssueChecklist
  module Patches    
    
    module IssueModelPatch
      
      module InstanceMethods    
        def change_parent_status  
          child_status = 5
          parent_status = 11
          
          if self.parent && (self.parent.children.collect(&:status_id).uniq == [child_status]) && (self.parent.status_id != parent_status) 
            current_parent = self.parent
            current_parent.status_id = parent_status 
            current_parent.save
          end
          
        end 
        

      end
  
      def self.included(base) # :nodoc: 
        base.class_eval do    
          unloadable # Send unloadable so it will not be unloaded in development
          
          has_many :checklist, :class_name => "IssueChecklist"
        end  
      end  
        
    end
    
  end
end  

Dispatcher.to_prepare do  

  unless Issue.included_modules.include?(RedmineIssueChecklist::Patches::IssueModelPatch)
    Issue.send(:include, RedmineIssueChecklist::Patches::IssueModelPatch)
  end

end