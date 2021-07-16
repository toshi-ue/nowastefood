module StocksHelper
  def background_color_consume(stock, not_consumed_stocks_rawmaterials)
    not_consumed_rawmaterial_ids = not_consumed_stocks_rawmaterials.keys

    if not_consumed_rawmaterial_ids.include?(stock.rawmaterial_id.to_s)
      ""
    else
      "will-consume"
    end
  end

  def days_left(rotted_at)
    left_days = (rotted_at - Time.zone.now.to_date).to_i

    if left_days >= 2
      "#{left_days}日"
    elsif left_days == 1
      "今日まで"
    elsif left_days < 1
      "#{left_days - 1}日"
    end
  end
end
