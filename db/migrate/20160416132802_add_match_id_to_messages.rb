class AddMatchIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :match_id, :integer, null: false
  end
end
