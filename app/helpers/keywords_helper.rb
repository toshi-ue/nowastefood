# frozen_string_literal: true

module KeywordsHelper
  def title_name(enum_key)
    case enum_key
    when "japanese"
      "和風"
    when "western"
      "洋風"
    when "chinese"
      "中華"
    when "other"
      "その他"
    when "lt_minutes5"
      "5分以下"
    when "lt_minutes10"
      "10分以下"
    when "lt_minutes20"
      "20分以下"
    when "gt_minutes21"
      "20分以上"
    when "not-enum-ranking"
      "お気に入り"
    end
  end
end
