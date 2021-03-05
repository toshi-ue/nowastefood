module StocksHelper
  def background_color_consume(stock, not_consumed_stocks_rawmaterials)
    not_consumed_rawmaterial_ids = not_consumed_stocks_rawmaterials.keys

    if not_consumed_rawmaterial_ids.include?(stock.rawmaterial_id.to_s)
      ""
    else
      "will-consume"
    end
  end
end
