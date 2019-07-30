class Blog < ApplicationRecord
  has_many :paragraphs, dependent: :destroy
  has_many :generals, dependent: :destroy, as: :generalable
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy, as: :bookmarkable
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :district

  validates :topic, :cover_photo, :address, presence: true

  mount_uploader :cover_photo, PictureUploader

  scope :sort_by_time, ->{order created_at: :desc}
  scope :get_by_author, ->(user_id){where user_id: user_id}
  scope :get_blog, ->(blog_id){where id: blog_id}
end
