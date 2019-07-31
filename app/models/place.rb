class Place < ApplicationRecord
  belongs_to :district
  enum status: {hotel: 0, restaurent: 1}
end
