class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :followed
  has_many :blogs, dependent: :destroy
  has_many :generals, as: :generalable
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save{email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.maxName}
  validates :email, format: {with: Settings.VALID_EMAIL_REGEX},
    presence: true, length: {maximum: Settings.maxEmail},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.minPassword}, allow_nil: true

  mount_uploader :avatar, PictureUploader

  has_secure_password

  scope :sort_by_name, ->{order :name}

  class << self
    def digest string
      cost = get_cost
      BCrypt::Password.create string, cost: cost
    end

    def get_cost
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update remember_digest: nil
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def current_user? user
    self == user
  end

  def blog_bookmarked? blog
    @get_bookmark_blog = Bookmark.get_bookmark self, blog, Settings.blog_s
    @get_bookmark_blog.present?
  end

  def place_bookmarked? place
    @get_bookmark_place = Bookmark.get_bookmark self, place, Settings.place_s
    @get_bookmark_place.present?
  end

  def self.from_omniauth auth
    where(provider: auth["provider"],
      uid: auth["uid"]).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = "123123123"
      user.save!
    end
  end

  def is_login_facebook?
    provider.blank?
  end

  private

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
