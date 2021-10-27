# frozen_string_literal: true

class Contact < ApplicationRecord
  enum category: { error: 0, request: 1, other: 2 }, _suffix: true
  validates :message, presence: true, length: { maximum: 200 }
  validates :subject, presence: true, length: { maximum: 50 }
end
