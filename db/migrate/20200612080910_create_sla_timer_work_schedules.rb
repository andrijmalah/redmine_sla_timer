class CreateSlaTimerWorkSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :sla_timer_work_schedules do |t|
      t.references :project, foreign_key: true, type: :integer
      t.text :days_time
    end
  end
end
