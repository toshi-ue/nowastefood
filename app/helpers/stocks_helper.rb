module StocksHelper
  def change_back_color(stock, rawmaterials_and_quantity_will_be_consumed, left_days)
    remaining_quantity = rawmaterials_and_quantity_will_be_consumed.key?(stock.rawmaterial_id) ? @rawmaterials_and_quantity_will_be_consumed[stock.rawmaterial_id] : -1

    # binding.pry
    if remaining_quantity > 0
      if Rational(stock.quantity) - remaining_quantity <= 0
        @rawmaterials_and_quantity_will_be_consumed[stock.rawmaterial_id] = -1
        @css_name = 'will-consume'
        'will-consume'
      end
    elsif left_days == 1
      @css_name = 'last-day'
      'last-day'
    elsif left_days < 1
      @css_name = 'oops'
      'oops'
    end
  end

  def disp_left_days(days)
    if days > 1
      "#{days}日"
    elsif days == 1
      "今日まで"
    elsif days < 1
      "#{days - 1}日"
    end
  end

  def left_days(rotted_at)
    (rotted_at - Time.zone.now.to_date).to_i
  end
end
