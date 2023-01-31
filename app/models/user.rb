# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :timeoutable, :trackable

  validates :default_serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }, if: -> { validation_context == :update_profile }
  validates :nickname, length: { in: 1..30 }

  has_many :favorites, dependent: :destroy, inverse_of: :user
  has_many :rawmaterials, dependent: :nullify
  has_many :owner_cuisines, class_name: "Cuisine", dependent: :nullify
  has_many :todaysmenus, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :cuisines, dependent: :nullify
  has_many :todaysmenu_cuisines, through: :todaysmenus, class_name: "Cuisine"

  mount_uploader :profile_image, ProfileImageUploader

  def already_favorite?(cuisine)
    favorites.exists?(cuisine_id: cuisine.id)
  end

  def already_menu_in_today?(cuisine_id)
    todaysmenus.exists?(cuisine_id: cuisine_id, created_at: Time.zone.now.all_day)
  end

  def self.create_account_as_guest
    require "open-uri"
    user_name = EnFaker::Name.unique.first_name
    # FIXME: openを使用するとセキュリティリスクがある？
    #   rubocopで The use of `Kernel#open` is a serious security risk. と表示される(Security/Open)
    # rubocop:disable Security/Open
    avatar = open(Faker::Avatar.image(slug: user_name, size: "150x150", format: "jpg"))
    avatar.close
    # rubocop:enable Security/Open

    self.create!(nickname: user_name, avatar: avatar.base_uri, email: "#{user_name.downcase}@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
    end
  end
end
