class Stock < ApplicationRecord
  before_validation :convert_specific_format
  belongs_to :rawmaterial
  belongs_to :user
  validates :quantity, presence: true, format: { with: %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}, message: "は数字(整数)で入力してください" }
  validates :user_id, presence: true

  def convert_specific_format
    # 空白を削除、 全角があれば半角に、文字列はそのまま
    self.quantity = quantity.gsub(/ 　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end
end
