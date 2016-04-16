class CreateMatchFinders < ActiveRecord::Migration[5.0]
  def change
    create_table :match_finders do |t|
      t.belongs_to :liker, null: false
      t.boolean :running, default: false
      t.text :error
      t.timestamps
    end
  end
end
