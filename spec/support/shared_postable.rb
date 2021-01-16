require 'rails_helper'

RSpec.shared_examples 'postable' do
  it { is_expected.to have_many(:posts).dependent(:destroy) }
end
