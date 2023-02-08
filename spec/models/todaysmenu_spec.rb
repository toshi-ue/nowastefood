# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todaysmenu do
  it '登録できること' do
    todaysmenu = build(:todaysmenu)
    todaysmenu.valid?
    expect(todaysmenu).to be_valid
  end

  describe '#create_hash_todaysmenus' do
    let(:user)        { create(:user) }
    let(:todaysmenu)  { create(:todaysmenu, cuisine_id: cuisine.id, serving_count: serving_count, user_id: user.id) }
    let(:cuisine)     { create(:cuisine) }
    let!(:foodstuff)  { create(:foodstuff, cuisine_id: cuisine.id, rawmaterial_id: rawmaterial.id, quantity: quantity) }
    let(:rawmaterial) { create(:rawmaterial) }

    context 'todaysmenuが1つ、foodstuffが1つのとき' do
      let(:quantity) { '1/3' }
      let(:serving_count) { 1 }

      it 'hashで帰ってくること({rawmaterial.id => fs.quantity)' do
        user = User.find(todaysmenu.user_id)
        todaysmenus = user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).search_in_today
        expect(todaysmenus.create_hash_todaysmenus(todaysmenus)).to eq({ rawmaterial.id => Rational(quantity) })
      end
    end

    context 'todaysmenusが1つ、foodstuffが複数のとき' do
      let!(:foodstuff2) { create(:foodstuff, cuisine_id: cuisine.id, rawmaterial_id: rawmaterial2.id, quantity: quantity2) }
      let(:rawmaterial2)  { create(:rawmaterial) }
      let(:quantity)      { '1/3' }
      let(:quantity2)     { '2/3' }
      let(:serving_count) { 1 }

      it 'hashで帰ってくること({rawmaterial.id => fs.quantity, rawmaterial(2).id => fs.quantity(2)})' do
        user = User.find(todaysmenu.user_id)
        todaysmenus = user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).search_in_today
        expect(todaysmenus.create_hash_todaysmenus(todaysmenus)).to eq({ rawmaterial.id => Rational(quantity),
                                                                         rawmaterial2.id => Rational(quantity2) })
      end
    end

    context 'todaysmenusが2つ、foodstuffが同一のrawmaterial_idのとき' do
      let!(:todaysmenu2) { create(:todaysmenu, cuisine_id: cuisine2.id, serving_count: serving_count, user_id: user.id) }
      let!(:foodstuff2)   { create(:foodstuff, cuisine_id: cuisine2.id, rawmaterial_id: rawmaterial.id, quantity: quantity2) }
      let(:cuisine2)      { create(:cuisine) }
      let(:quantity)      { '1/3' }
      let(:quantity2)     { '2/3' }
      let(:serving_count) { 1 }

      it 'hashで帰ってくること({rawmaterial.id => fs.quantity + fs.quantity2})' do
        user = User.find(todaysmenu.user_id)
        todaysmenus = user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).search_in_today
        expect(todaysmenus.create_hash_todaysmenus(todaysmenus)).to eq({ rawmaterial.id => Rational('1/1') })
      end
    end
  end
end
