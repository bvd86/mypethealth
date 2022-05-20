class RemoveVetFlagFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :vet_flag, :string
  end
end
