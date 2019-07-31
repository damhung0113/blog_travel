class General < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  belongs_to :generalable, polymorphic: true
end
