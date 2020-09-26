require 'rails_helper'

RSpec.describe Todaysmenu, type: :model do
  it "登録できること" do
    todaysmenu = build(:todaysmenu)
    todaysmenu.valid?
    expect(todaysmenu).to be_valid
  end

  it '同一のcuisine_id, user_idであれば登録できないこと' do
    cuisine = create(:cuisine)
    user = create(:user)
    menu = create(:todaysmenu, cuisine_id: cuisine.id, user_id: user.id)
    other_menu = build(:todaysmenu, cuisine_id: cuisine.id, user_id: user.id)
    other_menu.valid?
    expect(other_menu).to be_invalid
  end
end
