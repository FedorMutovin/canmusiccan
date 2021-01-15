class AddReferenceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :community, index: true, foreign_key: true
  end
end
