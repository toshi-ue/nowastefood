# frozen_string_literal: true

class Stock < ApplicationRecord
  before_validation :convert_specific_format

  validates :quantity, presence: true, format: { with: %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}, message: "は数字(整数)で入力してください" }
  validates :user_id, presence: true

  belongs_to :rawmaterial
  belongs_to :user

  scope :not_abandoned, lambda {
    where(abandoned_at: nil)
  }
  scope :not_consumed, lambda {
    where(consumed_at: nil)
  }


  def self.store_consumed_at(stocks, stocks_will_be_consumed)
    stocks.each do |stock|
      next if stocks_will_be_consumed[stock.rawmaterial_id].nil?

      result = Rational(stock.quantity) - stocks_will_be_consumed[stock.rawmaterial_id]
      if result.positive?
        stock.update_attribute(:quantity, result)
      else
        stock.delete
      end
    end
  end

  def get_remaining_stocks(stocks, todaysmenus)
    stocks_remainings = {}
    if todaysmenus.present?
      stocks = Hash[stocks.pluck(:rawmaterial_id, :quantity).to_h.map { |key, val| [key, Rational(val)] }]
      todaysmenus = @todaysmenus.create_hash_todaysmenus(@todaysmenus)
      stocks_results = @stocks.remaining_amount(stocks, todaysmenus)
      @stocks_not_plan_to_consume = stocks_results
    else
      @stocks_not_plan_to_consume = Hash[@stocks.pluck(:rawmaterial_id, :quantity).to_h.map { |key, val| [key.to_s, Rational(val)] }]
    end
  end

  # ユーザーが数字、空白、スラッシュを全角で入力しても許容するため
  # 空白を削除、 全角があれば半角に、文字列はそのまま
  def convert_specific_format
    self.quantity = quantity.gsub(/[[:space:]]/, '').tr("／", "/").strip.tr('０-９', '0-9')
  end

  def store_default_values
    self.rotted_at = Time.zone.now + Rawmaterial.find(self.rawmaterial_id).expiry_period.to_i.days
  end
end
