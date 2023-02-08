# frozen_string_literal: true

class Cuisine < ApplicationRecord
  enum cooking_time: { lt_minutes5: 5, lt_minutes10: 10, lt_minutes20: 20, gt_minutes21: 21 }
  enum genre: { japanese: 1, western: 2, chinese: 3, other: 99 }
  enum status: { draft: 0, published: 1 }

  validates :description, presence: true
  validates :genre, inclusion: { in: Cuisine.genres.keys }
  validates :main_image, presence: { message: 'を追加してください' }
  validates :name, presence: true, uniqueness: true
  validates :status, inclusion: { in: Cuisine.statuses.keys }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :foodstuffs, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :rawmaterials, through: :foodstuffs
  has_many :todaysmenus, dependent: :destroy

  scope :eight_contents, -> { includes(:user).limit(8) }

  include CommonScope
  mount_uploader :main_image, ImageUploader

  def toggle_status!
    draft? ? published! : draft!
  end
end
