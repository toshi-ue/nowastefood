class Stock < ApplicationRecord
  belongs_to :rawmaterial
  belongs_to :user
  # quantityのvalidation
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

  def cannot_save_except_specific_format
    errors.add(:quantity, "数量を入力してください") if quantity.blank?

    specific_format = '\A[0-9０-９]+[ 　]*[\/／0-9０-９]*[ 　]*[0-9０-９]+'
    # specific_formatと合致していれば変換
    if /#{specific_format}/.match?(quantity)
      # 空白を削除, 全角があれば半角に
      quantity.gsub(" " | "　", "").tr("／", "/").strip!.tr('０-９', '0-9')
              .else
      errors.add(:quantity, "例にしたがって入力してください") if quantity.blank?
    end
  end
end
