class AddVetIdToFeedbacks < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :vet_id, :integer
  end
end
