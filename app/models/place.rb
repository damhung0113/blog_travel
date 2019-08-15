class Place < ApplicationRecord
  PLACE_ATTRIBUTE = %i(name district_id description address vote cost
    photo status).freeze
  enum status: {hotel: 0, restaurant: 1}

  has_many :bookmarks, dependent: :destroy, as: :bookmarkable
  has_many :comments, as: :commentable, dependent: :destroy

  belongs_to :district

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

  mount_uploader :photo, PhotoUploader

  scope :find_address,
    ->(params){where "address LIKE :search", search: "%#{params}%" if params.present?}
  scope :order_by_vote, ->(params){order("vote #{params}")}
  scope :get_place, ->(place_id){where id: place_id}
  scope :get_place_by_district, ->(id){where district_id: id }
end
