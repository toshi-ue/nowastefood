class Foodstuff < ApplicationRecord
  before_save :convert_specific_format
  belongs_to :cuisine
  belongs_to :rawmaterial

  # FIXME: validationはかかる
  #         ただしvalidationメッセージは"数量を入力してください"と表示される
  validates :quantity, presence: true, format: { with: %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}, message: "は分数もしくは数字(整数)で入力してください" }
  # FIXME: validationなしでもrawmaterial_id は validationがかかる
  #         なぜ?
  # validates :rawmaterial_id, presence: { message: "を追加してください"}
  # ranked-model
  include RankedModel
  ranks :row_order, with_same: :cuisine_id

  # quantityのvalidation
  #  validationがokなら値を半角に変換して保存したい
  #   もとはstring
  #   変換する必要あり
  #   整数(大文字、小文字)ならok
  #     ok
  #       1
  #       １２
  #       1３
  #   分数(大文字、小文字)ならok
  #     ok
  #       1/1
  #       1 / 3
  #       １／１
  #       1　／ 　　１
  #   それ以外はng
  #   okであれば大文字の場合は小文字に変換

  # validates :cannot_save_except_specific_format

  def convert_specific_format
    # 空白を削除, 全角があれば半角に
    self.quantity = quantity.gsub(/ 　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end
end
