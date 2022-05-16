class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.references :consultation, null: false, foreign_key: true
      t.integer :price_cents

      t.timestamps
    end
  end
end
