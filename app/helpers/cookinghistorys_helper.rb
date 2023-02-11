# frozen_string_literal: true

module CookinghistorysHelper
  def time_ago(time)
    if time.today?
      '今日'
    elsif time.yesterday?
      '昨日'
    else
      "#{time_ago_in_words(time.to_date)}前"
    end
  end
end
