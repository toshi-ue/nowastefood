require 'rails_helper'

RSpec.describe Favorite, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = create(:user)
    @cuisine = create(:cuisine)
  end

  it "登録ができること" do
    favorite = build(:favorite, user_id: @user.id, cuisine_id: @cuisine.id)
    favorite.valid?
    expect(favorite).to be_valid
  end

  it "同一のuser_id, cuisine_idであれば無効であること" do
    favorite = create(:favorite, user_id: @user.id, cuisine_id: @cuisine.id)
    another_favorite = build(:favorite, user_id: @user.id, cuisine_id: @cuisine.id)
    another_favorite.valid?
    expect(another_favorite).to be_invalid
  end

end
