class CreatePatient < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
    	t.string :name
    	t.string :gender
    	t.integer :age
    	t.string :bed
    	t.string :diagnosis
    end
  end
end
