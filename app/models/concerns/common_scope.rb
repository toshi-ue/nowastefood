module CommonScope
  extend ActiveSupport::Concern

  included do
    scope :search_in_today, lambda {
      where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    }
  end
end
