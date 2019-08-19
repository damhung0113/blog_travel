class Comment < ApplicationRecord
  acts_as_tree order: "created_at ASC"
  has_one :general
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
