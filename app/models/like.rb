class Like < ApplicationRecord
  has_one :general
  belongs_to :user
  belongs_to :blog
end
