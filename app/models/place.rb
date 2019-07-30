class Place < ApplicationRecord
  belongs_to :district
  enum status: {hotel: 0, restaurant: 1}
  mount_uploader :photo, PhotoUploader
  PLACE_ATTRIBUTE = %i(name district_id description address vote cost photo status)

  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
  validates :description, presence: true,
    length: {maximum: Settings.maximum_length_description}
  validates :address, presence: true,
    length: {maximum: Settings.maximum_length_address}
  validates :vote, presence: true,
    numericality: {greater_than_or_equal_to: Settings.minximum_vote}
  validates :cost, presence: true,
    length: {maximum: Settings.maximum_length_cost}
  validates :photo, presence: true
end
