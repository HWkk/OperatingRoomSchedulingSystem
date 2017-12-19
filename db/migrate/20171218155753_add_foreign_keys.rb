class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :surgeries, :patients
  	add_foreign_key :surgeries, :doctors
  	add_foreign_key :night_schedules, :nurses, column: :nurse1_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse2_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse3_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse4_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse5_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse6_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse7_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse8_id
  	add_foreign_key :night_schedules, :nurses, column: :nurse9_id
  end
end
