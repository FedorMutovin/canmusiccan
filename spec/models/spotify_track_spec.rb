require 'rails_helper'

RSpec.describe SpotifyTrack, type: :model do
  it { belong_to :user }
  it { is_expected.to validate_presence_of :preview }
  it { is_expected.to validate_presence_of :image }
  it { is_expected.to validate_presence_of :artists }
  it { is_expected.to validate_presence_of :spotify_id }
  it { is_expected.to validate_presence_of :name }
end
