class AddColumnsToFeedbacks < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :vet_rating, :integer
    add_column :feedbacks, :friend_rating, :integer
  end
end
