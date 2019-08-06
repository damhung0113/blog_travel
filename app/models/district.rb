class District < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :places, dependent: :destroy
end
