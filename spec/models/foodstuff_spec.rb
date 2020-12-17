require 'rails_helper'

RSpec.describe Foodstuff, type: :model do
  describe "#convert_specific_format" do
    subject { foodstuff.convert_specific_format }

    let(:foodstuff) { Foodstuff.new(quantity: quantity) }

    context "OK" do
      context "半角数字のみの場合" do
        let(:quantity) { "1" }

        it { is_expected.to eq "1" }
      end

      context "全角数字のみの場合" do
        let(:quantity) { "１" }

        it { is_expected.to eq("1") }
      end

      context "スペースを含んでいる数字の場合" do
        let(:quantity) { " 1　" }

        it { is_expected.to eq "1" }
      end

      context "分数であること" do
        let(:quantity) { " 1/2" }

        it { is_expected.to eq "1/2" }
      end

      context "スペースを含んでいる分数であること" do
        let(:quantity) { " 1/2　" }

        it { is_expected.to eq "1/2" }
      end

      context "/、数字、スペース以外の文字列を含むこと" do
        let(:quantity) { "aaa" }

        it { is_expected.to eq "aaa" }
      end
    end
  end

  # TODO: best_cuisineメソッドのテストを書く
  # describe "#best_cuisine" do
  #   it "賞味期限が切れる食材を消費できる料理idを取得すること" do
  #     user = create(:user)
  #     rawmaterial = create(:rawmaterial)
  #     cuisine1 = create(:cuisine)
  #     foodstuff1 = create(:foodstuff, cuisine_id: cuisine1.id, rawmaterial_id: rawmaterial.id, quantity: "3/2")
  #     cuisine2 = create(:cuisine)
  #     foodstuff1 = create(:foodstuff, cuisine_id: cuisine2.id, rawmaterial_id: rawmaterial.id, quantity: "2")
  #     rawmaterial_unrelated = create(:rawmaterial)
  #     cuisine_unrelated = create(:cuisine)
  #     foodstuff_unrelated = create(:foodstuff, cuisine_id: cuisine_unrelated.id, rawmaterial_id: rawmaterial_unrelated.id, quantity: "2")
  #     todaysmenu = create(:todaysmenu, cuisine_id: cuisine_unrelated.id, user_id: user.id)
  #     # binding.pry
  #     stock = create(:stock, rawmaterial_id: rawmaterial.id, quantity: "1/2", user_id: user.id)
  #     foodstuffs = Foodstuff.where(rawmaterial_id: rawmaterial.id)

  #     cuisine_ids = todaysmenu.cuisine_id
  #     binding.pry
  #     # rawmaterial_want_to_consume = rawmaterial.id
  #     quantity_want_to_consume = { stock.rawmaterial_id.to_s => stock.quantity }
  #     expect(foodstuffs.best_cuisine(foodstuffs, cuisine_ids, quantity_want_to_consume, 1)).to eq foodstuff1.cuisine_id
  #   end
  # end

  describe "quantity" do
    context "OK" do
      it "数字のみであること" do
        foodstuff = build(:foodstuff, :only_half_size_number)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end

      it "分数であること" do
        foodstuff = build(:foodstuff, :only_full_width_number)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end

      context "特別に許可された文字列のとき" do
        it "適量は許可されること" do
          foodstuff = build(:foodstuff, quantity: "適量")
          foodstuff.valid?
          expect(foodstuff).to be_valid
        end

        it "少々は許可されること" do
          foodstuff = build(:foodstuff, quantity: "少々")
          foodstuff.valid?
          expect(foodstuff).to be_valid
        end

        it "お好みでは許可されること" do
          foodstuff = build(:foodstuff, quantity: "お好みで")
          foodstuff.valid?
          expect(foodstuff).to be_valid
        end
      end
    end

    context "NG" do
      it "/、数字、スペース以外の文字列を含むこと" do
        foodstuff = build(:foodstuff, quantity: "aaa")
        foodstuff.valid?
        expect(foodstuff).to be_invalid
      end

      it "特定のエラーメッセージを表示すること" do
        foodstuff = build(:foodstuff, quantity: "aaa")
        foodstuff.valid?
        expect(foodstuff.errors[:base]).to include "数量は分数、数字または指定の文字で入力してください(例: 1/2, 120など)"
      end
    end
  end

  describe "cuisine_id" do
    context "NG" do
      it "同一のcuisine_id, rawmaterial_idであれば無効であること" do
        foodstuff = create(:foodstuff)
        foodstuff_overlapping_cuisine_and_rawmaterial_id = build(:foodstuff, cuisine_id: foodstuff.cuisine_id, rawmaterial_id: foodstuff.rawmaterial_id)
        foodstuff_overlapping_cuisine_and_rawmaterial_id.valid?
        expect(foodstuff_overlapping_cuisine_and_rawmaterial_id).to be_invalid
      end
    end
  end
end
