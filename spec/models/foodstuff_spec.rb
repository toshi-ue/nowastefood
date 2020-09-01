require 'rails_helper'

RSpec.describe Foodstuff, type: :model do
  describe "quantityカラムのバリデーション" do
    context "OK" do
      it "数字のみ(半角)であること" do
        foodstuff = build(:foodstuff, :only_half_size_number)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end

      it "数字のみ(全角)であること" do
        foodstuff = build(:foodstuff, :only_full_width_number)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end

      it "分数であること" do
        foodstuff = build(:foodstuff, :only_full_width_number)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end

      it "スペースを含んでいる数字であること" do
        foodstuff = build(:foodstuff, :only_half_size_number_with_space)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end

      it "スペースを含んでいる分数であること" do
        foodstuff = build(:foodstuff, :full_width_fraction_with_space)
        foodstuff.valid?
        expect(foodstuff).to be_valid
      end
    end

    context "NG" do
      it "/、数字、スペース以外の文字列を含むこと" do
        foodstuff = build(:foodstuff, quantity: "aaa")
        foodstuff.valid?
        expect(foodstuff).to be_invalid
      end
    end
  end

  # TODO: 別ブランチでテスト
  describe "cuisine_idカラムのバリデーション" do
    # context "NG" do
    #   it "同一のcuisine_id, rawmaterial_idであれば無効であること"
    # end
  end

  describe "rawmaterial_idカラムのバリデーション" do
    # context "NG" do
    #   it "同一のcuisine_id, rawmaterial_idであれば無効であること"
    # end
  end

end
