class User < ApplicationRecord
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :followed
  has_many :blogs, dependent: :destroy
  has_many :generals, as: :generalable
  before_save {email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.maxName}
  validates :email, format: {with: Settings.VALID_EMAIL_REGEX},
  presence: true, length: {maximum: Settings.maxEmail},
  uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.minPassword}, allow_nil: true
  has_secure_password
end
