class SpotifyTrack < ApplicationRecord
  belongs_to :user, touch: true
  validates :name, :spotify_id, :artists, :image, :preview, presence: true
  validates :spotify_id, uniqueness: { scope: :user }

  def self.add_new(spotify_track)
    create(
      spotify_id: spotify_track.id,
      name: spotify_track.name,
      artists: spotify_track.artists[0].name,
      image: spotify_track.album.images[0]['url'],
      preview: spotify_track.preview_url
    )
  end
end
