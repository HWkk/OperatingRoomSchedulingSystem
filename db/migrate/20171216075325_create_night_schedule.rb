class CreateNightSchedule < ActiveRecord::Migration[5.1]
  def change
    create_table :night_schedules do |t|
    	t.date :date
    	t.integer :nurse1_id
    	t.integer :nurse2_id
    	t.integer :nurse3_id
    	t.integer :nurse4_id
    	t.integer :nurse5_id
    	t.integer :nurse6_id
    	t.integer :nurse7_id
    	t.integer :nurse8_id
    	t.integer :nurse9_id
    end
  end
end