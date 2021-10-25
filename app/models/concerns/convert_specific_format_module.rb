# frozen_string_literal: true

module ConvertSpecificFormatModule
  extend ActiveSupport::Concern

  # ユーザーが数字、空白、スラッシュを全角で入力しても許容するため
  # 空白を削除、 全角があれば半角に、文字列はそのまま
  def convert_specific_format
    self.quantity = quantity.gsub(/ 　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end
end
