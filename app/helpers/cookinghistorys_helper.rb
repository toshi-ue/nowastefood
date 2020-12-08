module CookinghistorysHelper
  def time_ago(time)
    if time.to_date.between?(Time.zone.now.yesterday.to_date.beginning_of_day, Time.zone.now.yesterday.to_date.end_of_day)
      "昨日"
    else
      "#{time_ago_in_words(time.to_date)}前"
    end
  end
end
