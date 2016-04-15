class Like < ApplicationRecord
  belongs_to :liker
  belongs_to :tinder_user
end
