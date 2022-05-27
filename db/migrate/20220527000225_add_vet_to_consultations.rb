class AddVetToConsultations < ActiveRecord::Migration[6.1]
  def change
    add_column :consultations, :vet_id, :integer
  end
end
