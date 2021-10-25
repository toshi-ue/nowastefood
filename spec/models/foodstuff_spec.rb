# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Foodstuff, type: :model do
  describe "#convert_specific_format" do
    subject { foodstuff.convert_specific_format }

    let(:foodstuff) { described_class.new(quantity: quantity) }

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
end
