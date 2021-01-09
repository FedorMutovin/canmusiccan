class SpotifyTracksController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def search_tracks
    @tracks = RSpotify::Track.search(params[:track_name]) unless params[:track_name].eql?("")
  end

  def create

  end

  def destroy

  end
end
