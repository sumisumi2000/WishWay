require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したバリデーションが機能しているか' do
      user = create(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end
end
