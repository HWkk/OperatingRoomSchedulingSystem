class CreateNightSchedule < ActiveRecord::Migration[5.1]
  def change
    create_table :night_schedules do |t|
    	t.date :date
    	t.string :nurse1_id
    	t.string :nurse2_id
    	t.string :nurse3_id
    	t.string :nurse4_id
    	t.string :nurse5_id
    	t.string :nurse6_id
    	t.string :nurse7_id
    	t.string :nurse8_id
    	t.string :nurse9_id
    end
  end
end