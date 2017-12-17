class CreateDoctor < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
    	t.string :name
    end
  end
end
