class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :user

  scope :get_bookmark,
    ->(user_id, bookmarkable_id, type){where user_id: user_id,
    bookmarkable_id: bookmarkable_id, bookmarkable_type: type}
end
