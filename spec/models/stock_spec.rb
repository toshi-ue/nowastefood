# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock do
  describe "#convert_specific_format" do
    it "空白は除去されること" do
      stock = build(:stock, quantity: " 1 ")
      stock.convert_specific_format
      expect(stock.quantity.to_s).to eq("1")
    end

    context "整数の場合" do
      it "全角でも半角で返ってくること" do
        stock = build(:stock, quantity: "１")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("1")
      end
    end

    context "分数の場合" do
      it "全角でも半角で返ってくること" do
        stock = build(:stock, quantity: "１／２")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("1/2")
      end
    end

    context "文字列の場合" do
      it "そのまま返すこと" do
        stock = build(:stock, quantity: "aaa")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("aaa")
      end
    end
  end

  describe "#quantity" do
    context "OK" do
      it '整数ならば有効' do
        stock = create(:stock, quantity: 1)
        expect(stock).to be_valid
      end

      it '1/2のような分数なら有効' do
        stock = create(:stock, quantity: "1/2")
        expect(stock).to be_valid
      end
    end

    context "NG" do
      it '数字を含まない文字列であること' do
        stock = build(:stock, quantity: "aaaa")
        stock.valid?
        expect(stock.errors.messages[:quantity]).to include("は数字(整数)で入力してください")
      end

      it '未入力であること' do
        stock = build(:stock, quantity: "")
        stock.valid?
        expect(stock.errors.messages[:quantity]).to include("を入力してください")
      end
    end
  end

  describe "#rawmaterial_id" do
    context "OK" do
      it "原材料idがあれば有効" do
        stock = create(:stock)
        expect(stock).to be_valid
      end
    end

    context "NG" do
      before do
        @user = create(:user)
      end

      it "なければ無効であること" do
        stock = build(:stock, rawmaterial_id: nil, user_id: @user.id)
        expect(stock).to be_invalid
      end

      it "なければエラーメッセージを表示すること" do
        stock = build(:stock, rawmaterial_id: nil, user_id: @user.id)
        stock.valid?
        expect(stock.errors[:rawmaterial]).to include("を入力してください")
      end
    end
  end

  # TODO: 必要ないことが確認できたら削除する
  # describe "#user_id" do
  #   it 'user_idがなければ無効' do
  #     stock = build(:stock, user_id: nil)
  #     stock.valid?
  #     expect(stock.errors.messages[:user_id]).to include('を入力してください')
  #   end
  # end
end
