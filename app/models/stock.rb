class Stock < ApplicationRecord
  before_save :convert_specific_format
  belongs_to :rawmaterial
  belongs_to :user
  # validate :uniqueness_rawmaterial_id
  validates :quantity, presence: true, format: { with: %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}, message: "は数字(整数)で入力してください" }
  # validates :quantity, presence: true, format: { with: /\A([0-9０-９]+|少々|適量|お好みで|)\z/, message: "特定の文字のみ使用できます" }
  # validates :rawmaterial_id, presence: true
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

  # validates :cannot_save_except_specific_format

  def convert_specific_format
    # 空白を削除、 全角があれば半角に、文字列はそのまま
    self.quantity = quantity.gsub(/ 　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end

  private
  def uniqueness_rawmaterial_id
    # gem deviseの current_userヘルパーが使えない
    stock = Stock.find_by(rawmaterial_id: self.rawmaterial_id, user_id: current_user.id)
    errors.add(:base, "すでにstockされている食材は登録できません") if stock && stock.id != self.id
  end
end
