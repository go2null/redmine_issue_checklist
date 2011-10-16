class CreateIssueChecklists < ActiveRecord::Migration
  def self.up
    create_table :issue_checklists do |t|
      t.boolean :is_done, :default => 0
      t.string :subject
      t.integer :position, :default => 1
      t.references :author
      t.references :issue 
    end
  end

  def self.down
    drop_table :issue_checklists
  end
end
