module CookinghistorysHelper
  def time_ago(time)
    if time.between?(Time.zone.now.yesterday.beginning_of_day, Time.zone.now.yesterday.end_of_day)
      "昨日"
    else
      "#{time_ago_in_words(time)}前"
    end
  end
end
