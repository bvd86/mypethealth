class ActiveAsDefaultForConsultations < ActiveRecord::Migration[6.1]
  def change
    change_column_default :consultations, :active, to: true
  end
end
