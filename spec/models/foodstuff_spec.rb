require 'rails_helper'

RSpec.describe Foodstuff, type: :model do
  describe "#convert_specific_format" do
    let(:foodstuff){ Foodstuff.new(quantity: quantity) }
    subject { foodstuff.convert_specific_format }
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
    end

    context "NG" do
      it "/、数字、スペース以外の文字列を含むこと" do
        foodstuff = build(:foodstuff, quantity: "aaa")
        foodstuff.valid?
        expect(foodstuff).to be_invalid
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
