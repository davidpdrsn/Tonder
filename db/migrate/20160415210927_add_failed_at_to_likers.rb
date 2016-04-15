class AddFailedAtToLikers < ActiveRecord::Migration[5.0]
  def change
    add_column :likers, :failed_at, :datetime
  end
end
