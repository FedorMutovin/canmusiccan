class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      t.text :description
      t.string :name, null: false
      t.references :creator, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
