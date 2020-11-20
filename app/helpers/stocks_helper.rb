module StocksHelper
  def background_color_consume(stocks, not_consumed_stocks, rawmaterial_id)
    # return "will-consume" if not_consumed_stocks.empty?
    tmp_stocks = Hash[stocks.pluck(:rawmaterial_id, :quantity).to_h.map { |key, val| [key, Rational(val)] }]

    # binding.pry
    will_consumed = false
    # stocksが存在しているとき
    if tmp_stocks
      # not_consumed_stocksが存在している時
      # binding.pry
      if not_consumed_stocks.empty?
        return "will-consume"
      else
        not_consumed_stocks.each do |ns|
          binding.pry
          if ns[0] == rawmaterial_id
            puts "c" * 40
            return ""
          else
            puts "d" * 40
            will_consumed = true
          end
        end
      end
    end
    # binding.pry
    if will_consumed
      "will-consume"
    else
      ""
    end
  end
end
