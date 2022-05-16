class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :vet_flag, :boolean
    add_column :users, :vet_specialty, :string
    add_column :users, :available, :boolean
  end
end
