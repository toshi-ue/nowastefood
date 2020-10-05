require 'rails_helper'

RSpec.describe Genre, type: :model do
  it "名前があれば登録できること" do
    genre = build(:genre)
    genre.valid?
    expect(genre).to be_valid
  end

  it "名前がなければ登録できないこと" do
    genre = build(:genre, name: "")
    genre.valid?
    expect(genre).to be_invalid
  end

  it "名前が重複しないこと" do
    genre = create(:genre, name: "ジャンル1")
    another_genre = build(:genre, name: "ジャンル1")
    expect(another_genre).to be_invalid
  end
end
