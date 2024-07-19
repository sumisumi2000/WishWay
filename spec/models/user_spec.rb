require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    context '成功パターン' do
      it '設定したバリデーションが機能しているか' do
        user = build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it 'email が被らない場合、バリデーションエラーが起きないか' do
        user = create(:user)
        user2 = build(:user, email: 'test@gmail.com')
        expect(user2).to be_valid
        expect(user2.errors).to be_empty
      end
    end
    context '失敗パターン' do
      it 'password が3文字未満の場合、バリデーションが機能して invalid になるか' do
        user = build(:user, password: 'xx')
        expect(user).to be_invalid
      end
      it 'password_confirmation が空の場合、バリデーションが機能して invalid になるか' do
        user = build(:user, password_confirmation: '')
        expect(user).to be_invalid
      end
      it 'password と password_confirmation が一致しない場合、バリデーションが機能して invalid になるか' do
        user = build(:user, password: 'password', password_confirmation: 'password_fake')
        expect(user).to be_invalid
      end
      it 'email が一意の値でない（既存のデータと重複する）場合、バリデーションが機能して invalid になるか' do
        user = create(:user)
        duplicated_user = build(:user, email: user.email)
        expect(duplicated_user).to be_invalid
      end
      it 'email が空の場合、バリデーションが機能して invalid になるか' do
        user = build(:user, email: '')
        expect(user).to be_invalid
      end
      it 'email が256文字以上の場合、バリデーションが機能して invalid になるか' do
        user = build(:user, email: 'a' * 256)
        expect(user).to be_invalid
      end
      it 'name が空の場合、バリデーションが機能して invalid になるか' do
        user = build(:user, name: '')
        expect(user).to be_invalid
      end
      it 'name が51文字以上の場合、バリデーションが機能して invalid になるか' do
        user = build(:user, name: 'a' * 51)
        expect(user).to be_invalid
      end
    end
  end
end
