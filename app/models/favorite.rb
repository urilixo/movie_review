class Favorite < ApplicationRecord
  belongs_to :movie
  belongs_to :review
end
