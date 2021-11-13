# frozen_string_literal: true

class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable
  has_many :foodcategories

  def self.create_account_as_guest
    faker_manager_name = Faker::Name.first_name
    self.create!(name: faker_manager_name, email: "#{faker_manager_name}@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
    end
  end

  def toggle_editable!
    update!(editable: !editable)
  end
end
