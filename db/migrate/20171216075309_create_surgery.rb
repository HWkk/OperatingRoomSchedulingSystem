class CreateSurgery < ActiveRecord::Migration[5.1]
  def change
    create_table :surgeries do |t|
    	t.date :date
    	t.string :time
    	t.integer :room
    	t.integer :table
    	t.integer :patient_id
    	t.string :department
    	t.string :ward
    	t.string :surgery_name
    	t.string :anesthesia_method
    	t.intger :doctor_id
    	t.string :assistant
    	t.string :instrument_nurse_id
    	t.string :roving_nurse_id
    	t.string :remark
    end
  end
end
