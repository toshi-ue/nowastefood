class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable

  has_many :favorites, dependent: :destroy, inverse_of: :user
  has_many :todaysmenus, dependent: :destroy
  def already_favorite?(cuisine)
    self.favorites.exists?(cuisine_id: cuisine.id)
  end

  def already_menu_in_today?(cuisine_id)
    self.todaysmenus.exists?(cuisine_id: cuisine_id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
