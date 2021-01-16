class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.belongs_to :postable, polymorphic: true
      t.timestamps
    end
  end
end
