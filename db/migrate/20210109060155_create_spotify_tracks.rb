class CreateSpotifyTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_tracks do |t|
      t.references :user, foreign_key: true
      t.string :spotify_id, null: false
      t.string :name, null: false
      t.string :artists, null: false
      t.string :image, null: false
      t.string :preview, null: false
      t.timestamps
    end
  end
end
