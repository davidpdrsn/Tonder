class AddRunningToLikers < ActiveRecord::Migration[5.0]
  def change
    add_column :likers, :running, :boolean, default: false
    add_column :likers, :error, :text
  end
end
