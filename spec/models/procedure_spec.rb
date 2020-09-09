require 'rails_helper'

RSpec.describe Procedure, type: :model do
  before do
    @cuisine = create(:cuisine)
  end

  describe "cooking_detail" do
    context "OK" do
      it "cooking_detailが入力されていること" do
        procedure = build(:procedure, cuisine_id: @cuisine.id)
        expect(procedure.valid?).to be true
      end
    end

    context "NG" do
      it "cooking_detailが未入力であること" do
        procedure = build(:procedure, cuisine_id: @cuisine.id, cooking_detail: "")
        expect(procedure.valid?).to be false
      end
    end
  end

  describe "cuisine_id" do
    context "OK" do
      it "存在するcuisineがcuisine_idに設定されていること" do
        procedure = build(:procedure, cuisine_id: @cuisine.id)
        expect(procedure.valid?).to be true
        # expect(procedure).to be_invalid
      end
    end

    context "NG" do
      it "cuisine_idに値が設定されていないこと" do
        procedure = build(:procedure, cuisine_id: nil)
        expect(procedure.valid?).to be false
      end
    end
  end

  # describe "row_order" do
  #   # ranked_modelを使用している
  # end

end
