class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable

  has_many :favorites, dependent: :destroy, inverse_of: :user
  # Ajaxで使用している自作メソッド
  def already_favorite?(cuisine)
    self.favorites.exists?(cuisine_id: cuisine.id)
  end
end
