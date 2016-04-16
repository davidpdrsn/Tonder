class AddFailedAtToMatchFinders < ActiveRecord::Migration[5.0]
  def change
    add_column :match_finders, :failed_at, :datetime
  end
end
