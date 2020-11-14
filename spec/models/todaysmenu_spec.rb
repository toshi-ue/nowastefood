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

  # TODO: create_hash_todaysmenusメソッドのテストを書く
  describe "#create_hash_todaysmenus" do
    let(:user) { create(:user) }
    let(:todaysmenu) { create(:todaysmenu, cuisine_id: cuisine.id, serving_count: serving_count, user_id: user.id) }
    let(:cuisine) { create(:cuisine) }
    let(:foodstuff) { create(:foodstuff, cuisine_id: cuisine.id, rawmaterial_id: rawmaterial.id, quantity: quantity) }
    let(:rawmaterial) { create(:rawmaterial) }

    context "todaysmenuが1つ、foodstuffが一つのとき、fs.quantityが1/3、tm.serving_countが1のとき" do
      let(:quantity) { "1/3" }
      let(:serving_count) { 1 }

      it "{todaysmenu(s).cuisine.foodstuffs.rawmaterial_id=>(Rational(todaysmenu(s).cuisine.foodstuffs.quantity) * todaymenu(s).serving_count)}の形式であること" do
        user = User.find(todaysmenu.user_id)
        fs1 = Foodstuff.find_by(cuisine_id: cuisine.id)
        cs1 = Cuisine.find_by(id: foodstuff.cuisine_id)
        binding.pry
        todaysmenus = user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).search_in_today
        # hashの結果がおかしい
        expect(todaysmenus.create_hash_todaysmenus(todaysmenus)).to eq({ "1": "(1/3)" })
      end
    end
  end
end
