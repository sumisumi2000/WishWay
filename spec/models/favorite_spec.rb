require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context '成功パターン' do
    it '設定したバリデーションが機能しているか' do
      favorite01 = create(:favorite)

      user = create(:user, email: 'test@example.com')
      wish_list = create(:wish_list, user: user)
      favorite02 = create(:favorite, wish_list: wish_list)
      expect(favorite02).to be_valid
    end
  end
  context '失敗パターン' do
    it 'user_id と wish_list_id の組み合わせがすでにデータベースに存在する場合、バリデーションが機能して invalid になるか' do
      favorite = create(:favorite)
      copy = Favorite.create(user: favorite.user, wish_list: favorite.wish_list)
      expect(copy).to be_invalid
    end
  end
end
