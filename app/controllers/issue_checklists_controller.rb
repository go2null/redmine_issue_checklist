class IssueChecklistsController < ApplicationController
  unloadable
  
  before_filter :find_checklist_item, :only => [:done, :delete]
  before_filter :find_issue_project, :only => :new
  before_filter :authorize

  def new
    (render_403; return false) unless (User.current.allowed_to?({:controller => :issue_checklists, :action => :new}, @project))
    @checklist_item = IssueChecklist.new()
    @checklist_item.subject = params[:new_checklist_item]
    @checklist_item.issue_id = params[:issue_id]
    @checklist_item.author_id = User.current.id
    
    if @checklist_item.save
      respond_to do |format|
        format.js do 
          render :update do |page|   
            page["new-checklist-form"].reset     
            page.insert_html :bottom, "issue_checklist_items", :partial => 'checklist_item', :object => @checklist_item, :locals => {:issue => @checklist_item.issue}
            page["checklist_item_#{@checklist_item.id}"].visual_effect :appear    
            flash.discard   
          end
        end if request.xhr?       
        format.html {redirect_to :back}
      end
    else
      redirect_to :back 
    end
    
  end
  
  def done
    (render_403; return false) unless @checklist_item.editable_by?(User.current)
    
    @checklist_item.is_done = params[:is_done]
    @checklist_item.save
    respond_to do |format|
      format.js do 
        render :update do |page|  
            page["checklist_item_#{@checklist_item.id}"].visual_effect :appear   
        end
      end     
      format.html {redirect_to :back }
    end
    
  end     
  
  def delete
    (render_403; return false) unless @checklist_item.editable_by?(User.current)
    
    @checklist_item.delete
    respond_to do |format|
      format.js do 
        render :update do |page|  
            page["checklist_item_#{@checklist_item.id}"].visual_effect :fade   
        end
      end     
      format.html {redirect_to :back }
    end
    
  end     
  
  private
  
  def find_issue_project
    @issue = Issue.find(params[:issue_id])
    @project = @issue.project
  end
  
  
  def find_checklist_item
    @checklist_item = IssueChecklist.find(params[:checklist_item_id]) 
    @project = @checklist_item.issue.project
  end
  
  
end
