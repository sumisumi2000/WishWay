require 'rails_helper'

RSpec.describe WishList, type: :model do
  describe 'バリデーションチェック' do
    context '成功パターン' do
      it '設定したバリデーションが機能しているか' do
        wish_list = create(:wish_list)
        expect(wish_list).to be_valid, 'バリデーションに失敗しました'
        expect(wish_list.errors).to be_empty
      end
    end
    context '失敗パターン' do
      it 'title が空の場合、バリデーションが機能して invalid になるか' do
        wish_list = build(:wish_list, title: '')
        expect(wish_list).to be_invalid
      end
      it 'title が256文字以上の場合、バリデーションが機能して invalid になるか' do
        wish_list = build(:wish_list, title: 'a' * 256)
        expect(wish_list).to be_invalid
      end
      it 'is_public が空の場合、バリデーションが機能して invalid になるか' do
        wish_list = build(:wish_list, is_public: nil)
        expect(wish_list).to be_invalid
      end
      it 'granted_wish_rate が 0 未満の場合、バリデーションが機能して invalid になるか' do
        wish_list = build(:wish_list, granted_wish_rate: -20)
        expect(wish_list).to be_invalid
      end
      it 'granted_wish_rate が 101以上の場合、バリデーションが機能して invalid になるか' do
        wish_list = build(:wish_list, granted_wish_rate: 200)
        expect(wish_list).to be_invalid
      end
    end
  end
end
