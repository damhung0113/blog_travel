class District < ApplicationRecord
  has_many :blogs, dependent: true
  has_many :places, dependent: true
end
