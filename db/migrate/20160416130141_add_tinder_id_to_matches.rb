class AddTinderIdToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :tinder_id, :string, null: false
  end
end
