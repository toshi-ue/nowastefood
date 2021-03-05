require 'rails_helper'

RSpec.describe Foodcategory, type: :model do
  it '料理区分名があれば有効' do
    foodcategory = FactoryBot.build(:foodcategory, name: 'aaa')
    expect(foodcategory).to be_valid
  end

  it '料理区分名がuniqueであれば有効' do
    FactoryBot.create(:foodcategory, name: 'aaa')
    foodcategory = FactoryBot.build(:foodcategory, name: 'bbb')
    expect(foodcategory).to be_valid
  end

  it '料理区分名がなければ無効' do
    foodcategory = FactoryBot.build(:foodcategory, name: '')
    foodcategory.valid?
    expect(foodcategory.errors[:name]).to include("を入力してください")
  end

  it '料理区分名がuniqueでなければ無効' do
    FactoryBot.create(:foodcategory, name: 'aaa')
    foodcategory = FactoryBot.build(:foodcategory, name: 'aaa')
    expect(foodcategory).to be_invalid
  end
end
