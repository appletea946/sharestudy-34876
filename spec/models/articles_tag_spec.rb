require 'rails_helper'

RSpec.describe ArticlesTag, type: :model do
  before do
    # user = FactoryBot.create(:user)
    # group = FactoryBot.create(:group, user_id: user.id)
    # tag = FactoryBot.create(:tag)
    # @articles_tag = FactoryBot.build(:articles_tag, name: tag.name, group_id: group.id, user_id: user.id)
    # sleep 0.1
    @articles_tag = FactoryBot.build(:articles_tag)
  end
  describe '記事投稿機能' do
    context '投稿できる時' do
      it '情報が正しく入力されていれば投稿できる' do
        expect(@articles_tag).to be_valid
      end
      it 'グループが空でも投稿できる' do
        @articles_tag.group_id = ''
        expect(@articles_tag).to be_valid
      end
      it '既存でないtagでも保存できる' do
        @articles_tag.name += 's'
        expect(@articles_tag).to be_valid
      end
    end
    context '投稿できないとき' do
      it 'titleが空では投稿できない' do
        @articles_tag.title = ''
        @articles_tag.valid?
        expect(@articles_tag.errors.full_messages).to include("Title can't be blank")
      end
      it 'tagが空では投稿できない' do
        @articles_tag.name = ''
        @articles_tag.valid?
        expect(@articles_tag.errors.full_messages).to include("Name can't be blank")
      end
      it 'contentが空では投稿できない' do
        @articles_tag.content = ''
        @articles_tag.valid?
        expect(@articles_tag.errors.full_messages).to include("Content can't be blank")
      end
      it 'user_idが空では投稿できない' do
        @articles_tag.user_id = ''
        @articles_tag.valid?
        expect(@articles_tag.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
