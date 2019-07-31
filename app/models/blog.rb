class Blog < ApplicationRecord
  has_many :paragraphs, dependent: true
  has_many :generals, dependent: true, as: :generalable
  belongs_to :user
  belongs_to :district
end
