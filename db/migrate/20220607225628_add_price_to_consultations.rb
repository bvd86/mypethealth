class AddPriceToConsultations < ActiveRecord::Migration[6.1]
  def change
    add_monetize :consultations, :price, currency: { present: false }
    add_column :consultations, :status, :string
    add_column :consultations, :checkout_session_id, :string
  end
end
