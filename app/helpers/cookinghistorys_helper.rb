module CookinghistorysHelper
  def time_ago(time)
    now = Time.zone.now
    if now.today?
      "今日"
    elsif now.yesterday?
      "昨日"
    else
      "#{time_ago_in_words(time.to_date)}前"
    end
  end
end
