require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'nickname' do
    context '更新するとき' do
      it '10文字以内のとき更新できること' do
        user = build(:user, nickname: "a" * 10)
        expect(user.save(context: :update_profile)).to be_truthy
      end

      it '31文字のとき更新できないこと' do
        user = build(:user, nickname: "a" * 31)
        expect(user.save(context: :update_profile)).to be_falsy
      end

      it 'nilのとき更新できないこと' do
        user = build(:user, nickname: nil)
        expect(user.save(context: :update_profile)).to be_falsy
      end
    end
  end
end
