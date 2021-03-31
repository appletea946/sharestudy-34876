class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments
  has_many :like_users
  has_many :like_articles
  has_one_attached :image
  has_many :user_group_relations
  has_many :groups, through: :user_group_relations

  validates :nickname, presence: true
end
