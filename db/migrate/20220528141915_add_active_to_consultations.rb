class AddActiveToConsultations < ActiveRecord::Migration[6.1]
  def change
    add_column :consultations, :active, :boolean
  end
end
