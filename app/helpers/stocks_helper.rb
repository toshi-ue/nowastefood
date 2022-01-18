# frozen_string_literal: true

module StocksHelper
  def change_back_color(stock, rawmaterials_and_quantity_will_be_consumed, left_days)
    remaining_quantity = rawmaterials_and_quantity_will_be_consumed.key?(stock.rawmaterial_id) ? @rawmaterials_and_quantity_will_be_consumed[stock.rawmaterial_id] : -1

    if remaining_quantity.positive?
      @rawmaterials_and_quantity_will_be_consumed[stock.rawmaterial_id] = remaining_quantity - Rational(stock.quantity)
      if Rational(stock.quantity) - remaining_quantity <= 0
        @css_name = 'will-consume'
        'will-consume'
      else
        return_css_name_by_left_days(left_days)
      end
    else
      return_css_name_by_left_days(left_days)
    end
  end

  def check_disp_auto_todaysmenu(css_name)
    css_name != 'will-consume'
  end

  def disp_left_days(days)
    if days > 1
      "あと#{days}日"
    elsif days == 1
      "今日まで"
    elsif days < 1
      "#{days - 1}日"
    end
  end

  def left_days(rotted_at)
    (rotted_at - Time.zone.now.to_date).to_i
  end

  def return_css_name_by_left_days(left_days)
    if left_days > 1
      @css_name = 'safe'
      'safe'
    elsif left_days == 1
      @css_name = 'last-day'
      'last-day'
    elsif left_days < 1
      @css_name = 'oops'
      'oops'
    else
      @css_name = 'something-went-wrong'
      'something-went-wrong'
    end
  end
end
