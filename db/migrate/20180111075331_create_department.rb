class CreateDepartment < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
    	t.string :name
    end
  end
end
