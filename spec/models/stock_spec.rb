require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe "#quantity" do
    context "OK" do
      it '整数ならば有効' do
        stock = FactoryBot.create(:stock, quantity: 1)
        expect(stock).to be_valid
      end

      it '1/2のような分数なら有効' do
        stock = FactoryBot.create(:stock, quantity: "1/2")
        expect(stock).to be_valid
      end

      it "空白は除去される" do
        stock = FactoryBot.build(:stock, quantity: " 1 ")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("1")
      end

      it "全角は半角に変換される" do
        stock = FactoryBot.build(:stock, quantity: " １／２ ")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("1/2")
      end
    end

    context "NG" do
      it '文字列の場合は無効' do
        stock = FactoryBot.build(:stock, quantity: "aaaa")
        stock.valid?
        expect(stock.errors.messages[:quantity]).to include("は数字(整数)で入力してください")
      end
    end
  end

  describe "#rawmaterial_id" do
    context "OK" do
      it "原材料idがあれば有効" do
        stock = FactoryBot.create(:stock)
        expect(stock).to be_valid
      end
    end

    context "NG" do
      it "原材料idがなければ無効" do
        stock = FactoryBot.build(:stock, rawmaterial_id: nil)
        expect(stock).to be_invalid
      end
    end
  end

  describe "#user_id" do
    it 'user_idがなければ無効' do
      stock = FactoryBot.build(:stock, user_id: nil)
      stock.valid?
      expect(stock.errors.messages[:user_id]).to include('を入力してください')
    end
  end
end
