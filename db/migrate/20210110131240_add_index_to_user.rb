class AddIndexToUser < ActiveRecord::Migration[6.1]
  def change
    add_index :spotify_tracks, [:spotify_id, :user_id], unique: true
  end
end
