class CreateSlaTimerSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :sla_timer_settings do |t|
      t.references :project, foreign_key: true, type: :integer
      t.float :reaction_time
      t.string :decoration
    end
  end
end
