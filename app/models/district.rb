class District < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :places, dependent: :destroy

  scope :district_by_name, ->(district_name){where name: district_name}
  scope :order_district, ->{order id: :desc}
  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
end
