require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'バリデーションチェック' do
    context '成功パターン' do
      it '設定したバリデーションが機能しているか' do
        notification = create(:notification)
        expect(notification).to be_valid, 'バリデーションに失敗しました'
        expect(notification.errors).to be_empty
      end
    end
    context '失敗パターン' do
      it 'is_required が空の場合、バリデーションが機能して invalid になるか' do
        notification = build(:notification, is_required: '')
        expect(notification).to be_invalid
      end
    end
  end
end
