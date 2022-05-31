class AddSpeciesToConsultations < ActiveRecord::Migration[6.1]
  def change
    add_column :consultations, :species, :string
  end
end
