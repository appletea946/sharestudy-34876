require 'rails_helper'

RSpec.describe UsersGroup, type: :model do
  before do
    user = FactoryBot.create(:user)
    @users_group = FactoryBot.build(:users_group, user_id: user.id)
  end
  describe 'グループ作成機能' do
    context 'グループ作成できるとき' do
      it '情報が正しく入力されていると作成できる' do
        expect(@users_group).to be_valid
      end
    end
    context 'グループ作成できないとき' do
      it 'nameが空だと作成できない' do
        @users_group.name = ''
        @users_group.valid?
        expect(@users_group.errors.full_messages).to include("Name can't be blank")
      end
      it 'passwordが空だと作成できない' do
        @users_group.password = ''
        @users_group.valid?
        expect(@users_group.errors.full_messages).to include("Password can't be blank")
      end
      it 'Userが紐づいていないと作成できない' do
        @users_group.user_id = ''
        @users_group.valid?
        expect(@users_group.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
