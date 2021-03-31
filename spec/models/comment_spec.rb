require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメント投稿機能' do
    context 'コメントできるとき' do
      it '情報が正しく入力されていればコメントできる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメントできないとき' do
      it 'contentが空ならコメントできない' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが空ならコメントできない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it 'articleが空ならコメントできない' do
        @comment.article = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Article must exist')
      end
    end
  end
end
