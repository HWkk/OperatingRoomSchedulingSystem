class CreateNurse < ActiveRecord::Migration[5.1]
  def change
    create_table :nurses do |t|
    	t.string :name
    	t.string :gender
    	t.date :birthday
    	t.string :id_card_num
    	t.string :phone_number
    	t.float :salary
    	t.date :inaugural_date
    	t.boolean :is_lactation
    	t.boolean :is_pregnant
    	t.string :department
    	t.string :qualification
    	t.string :is_experienced
    	t.string :has_coach_qualification
    end
  end
end