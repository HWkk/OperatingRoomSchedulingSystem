class AddHospitalizedNumberToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :hospitalized_number, :string
  end
end
