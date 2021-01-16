module Postable
  extend ActiveSupport::Concern

  included do
    has_many :posts, dependent: :destroy, as: :postable
  end
end
