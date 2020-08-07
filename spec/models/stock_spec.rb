require 'rails_helper'

RSpec.describe Stock, type: :model do
  # 以下は全てquantityプロパティのvalidationテスト
  #   describe, contextの使い方は合っているか?
  describe "#quantity" do
    context "OK" do
      it '整数ならば有効' do
        stock = FactoryBot.build(:stock, quantity: 1)
        expect(stock).to be_valid
      end

      it '1/2のような分数なら有効' do
        stock = FactoryBot.build(:stock, quantity: "1/2")
        expect(stock).to be_valid
      end
    end

    context "NG" do
      it '文字列の場合は無効' do
        stock = FactoryBot.build(:stock, quantity: "aaaa")
        stock.valid?
        expect(stock.errors.messages[:quantity]).to include("は数字(整数)で入力してください")
      end
    end

    #   フォームではログイン済みのユーザーid情報を
    #   current_user.idで代入している
    it 'ユーザーidがなければ無効' do
      stock = FactoryBot.build(:stock, user_id: nil)
      expect(stock).to be_valid
    end

    it '原材料idが入力されていれば有効' do
      stock = FactoryBot.build(:stock, user_id: nil)
      expect(stock).to be_valid
    end
  end
end
