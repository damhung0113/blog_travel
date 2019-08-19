class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :user

  scope :get_bookmark,
    ->(u, b, t){where user_id: u, bookmarkable_id: b, bookmarkable_type: t}
end
