class CreateLeaves < ActiveRecord::Migration[5.1]
  def change
    create_table :leaves do |t|
    	t.date :date
    	t.integer :nurse_id
    	t.string :remark
    end
    add_foreign_key :leaves, :nurses, column: :nurse_id
  end
end
