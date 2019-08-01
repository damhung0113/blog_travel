class Blog < ApplicationRecord
  has_many :paragraphs, dependent: :destroy
  has_many :generals, dependent: :destroy, as: :generalable
  belongs_to :user
  belongs_to :district
end
