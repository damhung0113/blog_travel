class Paragraph < ApplicationRecord
  belongs_to :blog

  mount_uploader :picture, PictureUploader

  validates :content, presence: true
end
