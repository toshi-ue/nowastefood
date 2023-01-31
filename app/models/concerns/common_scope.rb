# frozen_string_literal: true

module CommonScope
  extend ActiveSupport::Concern

  included do
    scope :search_in_today, lambda {
      now = Time.current
      where(created_at: now.all_day)
    }
  end
end
