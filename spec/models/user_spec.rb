require 'rails_helper'

RSpec.describe User, type: :model do
  # before do
  #   @user = create(:user)
  #   sign_in @user
  #   get root_path
  # end

  describe 'nickname' do
    context '更新するとき' do
      it '10文字以内のとき更新できること' do
        user = build(:user, nickname: "a" * 10)
        expect(user.save(context: :update_profile)).to be_truthy
      end

      it '11文字のとき更新できないこと' do
        user = build(:user, nickname: "a" * 11)
        expect(user.save(context: :update_profile)).to be_falsy
      end

      it 'nilのとき更新できないこと' do
        user = build(:user, nickname: nil)
        expect(user.save(context: :update_profile)).to be_falsy
      end
    end
  end
end
