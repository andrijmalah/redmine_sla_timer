class CreateSlaIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :sla_issues do |t|
      t.references :issue, foreign_key: true, type: :integer
      t.float :reaction_time
    end
  end
end
