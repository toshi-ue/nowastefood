# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Foodcategory do
  it '料理区分名があれば有効' do
    foodcategory = build(:foodcategory, name: 'aaa')
    expect(foodcategory).to be_valid
  end

  it '料理区分名がuniqueであれば有効' do
    create(:foodcategory, name: 'aaa')
    foodcategory = build(:foodcategory, name: 'bbb')
    expect(foodcategory).to be_valid
  end

  it '料理区分名がなければ無効' do
    foodcategory = build(:foodcategory, name: '')
    foodcategory.valid?
    expect(foodcategory.errors[:name]).to include("を入力してください")
  end

  it '料理区分名がuniqueでなければ無効' do
    create(:foodcategory, name: 'aaa')
    foodcategory = build(:foodcategory, name: 'aaa')
    expect(foodcategory).to be_invalid
  end
end
