class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :species
      t.string :breed

      t.timestamps
    end
  end
end
