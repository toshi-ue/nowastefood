require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe "#convert_specific_format" do
    it "空白は除去されること" do
      stock = FactoryBot.build(:stock, quantity: " 1 ")
      stock.convert_specific_format
      expect(stock.quantity.to_s).to eq("1")
    end

    context "整数の場合" do
      it "全角でも半角で返ってくること" do
        stock = FactoryBot.build(:stock, quantity: "１")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("1")
      end
    end

    context "分数の場合" do
      it "全角でも半角で返ってくること" do
        stock = FactoryBot.build(:stock, quantity: "１／２")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("1/2")
      end
    end

    context "文字列の場合" do
      it "そのまま返すこと" do
        stock = FactoryBot.build(:stock, quantity: "aaa")
        stock.convert_specific_format
        expect(stock.quantity.to_s).to eq("aaa")
      end
    end
  end

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
    end

    context "NG" do
      it '数字を含まない文字列であること' do
        stock = FactoryBot.build(:stock, quantity: "aaaa")
        stock.valid?
        expect(stock.errors.messages[:quantity]).to include("は数字(整数)で入力してください")
      end

      it '未入力であること' do
        stock = FactoryBot.build(:stock, quantity: "")
        stock.valid?
        expect(stock.errors.messages[:quantity]).to include("を入力してください")
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
      before do
        @user = create(:user)
      end

      it "なければ無効であること" do
        stock = FactoryBot.build(:stock, rawmaterial_id: nil, user_id: @user.id)
        expect(stock).to be_invalid
      end

      it "なければエラーメッセージを表示すること" do
        stock = FactoryBot.build(:stock, rawmaterial_id: nil, user_id: @user.id)
        stock.valid?
        expect(stock.errors[:rawmaterial]).to include("を入力してください")
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

  # TODO: remaining_amountメソッドのテストを書く
  describe "#remaining_amount" do
    context "消費される予定がない食材があるとき" do
      it "消費される予定がない食材、数量をhashで返すこと" do
        user = create(:user, default_serving_count: 1)
        rawmaterial1 = create(:rawmaterial)
        rawmaterial2 = create(:rawmaterial)
        stock1 = create(:stock, user_id: user.id, rawmaterial_id: rawmaterial1.id, quantity: "1/2")
        stock2 = create(:stock, user_id: user.id, rawmaterial_id: rawmaterial2.id, quantity: "1")
        stocks_hash = Hash[user.stocks.pluck(:rawmaterial_id, :quantity).to_h.map { |key, val| [key, Rational(val)] }]
        cuisine = create(:cuisine)
        cuisine2 = create(:cuisine)
        foodstuff = create(:foodstuff, cuisine_id: cuisine.id, rawmaterial_id: rawmaterial1.id, quantity: "1/3")
        todaysmenu1 = create(:todaysmenu, user_id: user.id, cuisine_id: cuisine.id)
        todaysmenu2 = create(:todaysmenu, user_id: user.id, cuisine_id: cuisine2.id)
        todaysmenus_hash = user.todaysmenus.create_hash_todaysmenus(user.todaysmenus)
        expect(user.stocks.remaining_amount(stocks_hash, todaysmenus_hash)).to eq({ rawmaterial1.id.to_s => Rational(stock1.quantity) - Rational(foodstuff.quantity), rawmaterial2.id.to_s => Rational(stock2.quantity) })
      end
    end
  end
end
