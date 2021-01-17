class CreateDemotracks < ActiveRecord::Migration[6.1]
  def change
    create_table :demotracks do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
