module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :activities, :as => :trackable
  end
end