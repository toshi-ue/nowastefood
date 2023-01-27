module CookinghistorysHelper
  def time_ago(time)
    if time.today?
      puts "a passed"
      "今日"
    elsif time.yesterday?
      puts "b passed"
      "昨日"
    else
      puts "c passed"
      "#{time_ago_in_words(time.to_date)}前"
    end
  end
end
