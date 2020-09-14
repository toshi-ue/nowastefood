class Stock < ApplicationRecord
  before_save :convert_specific_format
  belongs_to :rawmaterial
  belongs_to :user
  validates :quantity, presence: true, format: { with: %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}, message: "は数字(整数)で入力してください" }
  validates :user_id, presence: true

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
  def convert_specific_format
    # 空白を削除、 全角があれば半角に、文字列はそのまま
    self.quantity = quantity.gsub(/ 　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end
end
