class LikeUser < ApplicationRecord
  has_many :users

  validates :give_user, presence: true
  validates :receive_user, presence: true
end
