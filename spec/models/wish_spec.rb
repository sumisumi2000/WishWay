require 'rails_helper'

RSpec.describe Wish, type: :model do
  describe 'バリデーションチェック' do
    context '成功パターン' do
      it '設定したバリデーションが機能しているか' do
        wish = create(:wish)
        expect(wish).to be_valid, 'バリデーションに失敗しました'
        expect(wish.errors).to be_empty
      end
    end
    context '失敗パターン' do
      it 'title が空の場合、バリデーションが機能して invalid になるか' do
        wish = build(:wish, title: '')
        expect(wish).to be_invalid
      end
      it 'title が256文字以上の場合、バリデーションが機能して invalid になるか' do
        wish = build(:wish, title: 'a' * 256)
        expect(wish).to be_invalid
      end
      it 'granted が空の場合、バリデーションが機能して invalid になるか' do
        wish = build(:wish, granted: nil)
        expect(wish).to be_invalid
      end
    end
  end
end
