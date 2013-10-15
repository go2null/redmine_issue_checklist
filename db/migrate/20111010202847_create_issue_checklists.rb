class CreateIssueChecklists < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'issue_checklists'
      drop_table :issue_checklists
    end
    create_table :issue_checklists do |t|
      t.boolean :is_done, :default => false
      t.string :subject
      t.integer :position, :default => 1
      t.references :issue, :null => false 
    end
  end
end
