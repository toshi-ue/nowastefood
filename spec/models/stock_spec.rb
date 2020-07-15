require 'rails_helper'

RSpec.describe Stock, type: :model do
  context 'ユーザーがログインしている場合' do
    it '個数が入力されている場合'
    it '整数ならば有効'
    it '1/2のような分数なら有効'
    it 'それ以外なら無効'
    it 'ユーザーidがなければ無効'
    it '原材料idが入力されていれば有効'
    it '原材料idが入力されていなければ無効'
  end
end
