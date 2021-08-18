class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable
  has_many :favorites, dependent: :destroy, inverse_of: :user
  has_many :rawmaterials, dependent: :nullify
  has_many :owner_cuisines, class_name: "Cuisine", dependent: :nullify
  has_many :todaysmenus, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :cuisines, through: :todaysmenus
  validates :nickname, length: { in: 1..30 }, if: -> { validation_context == :update_profile }
  validates :default_serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }, if: lambda {
                                                                                                                                          validation_context == :update_profile
                                                                                                                                        }
  mount_uploader :profile_image, ProfileImageUploader

  def already_favorite?(cuisine)
    self.favorites.exists?(cuisine_id: cuisine.id)
  end

  def already_menu_in_today?(cuisine_id)
    self.todaysmenus.exists?(cuisine_id: cuisine_id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def self.create_account_as_guest
    faker_user_name = Faker::Name.first_name
    self.create!(nickname: faker_user_name, email: "#{faker_user_name}@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
    end
  end
end
