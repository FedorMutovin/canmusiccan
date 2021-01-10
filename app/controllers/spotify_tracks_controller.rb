class SpotifyTracksController < ApplicationController
  protect_from_forgery except: :search_tracks
  before_action :authenticate_user!
  before_action :track, only: :destroy
  skip_authorization_check

  def search_tracks
    @tracks = RSpotify::Track.search(params[:track_name]) unless params[:track_name].eql?('')
  end

  def create
    @spotify_track = RSpotify::Track.find(params[:track_id])
    @track = current_user.spotify_tracks.add_new(@spotify_track)
  end

  def destroy
    authorize! :destroy, @track
    @track.destroy
  end

  private

  def track
    @track ||= SpotifyTrack.find(params[:id])
  end
end
