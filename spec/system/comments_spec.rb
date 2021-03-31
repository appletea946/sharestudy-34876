require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @comment = FactoryBot.build(:comment, user_id: @user.id, article_id: @article.id)
  end

  describe 'コメント機能' do
    context 'コメントできるとき' do
      it '入力されていればコメントできる' do
        # ログインする
        sign_in(@user)
        # トップページに記事があることを確認
        expect(page).to have_content('title')
        # 記事詳細ページに遷移
        visit article_path(@article.id)
        # コメント欄にコメントを記入
        fill_in 'comment[content]', with: @comment.content
        # コメントを送信するとcommentのカウントが１増える
        expect  do
          find("input[name='commit']").click
        end.to change { Comment.count }.by(1)
        # 記事詳細ページにいることを確認する
        expect(current_path).to eq(article_path(@article.id))
        # コメントがあることを確認する
        expect(page).to have_content('content')
      end
    end
    context 'コメントできないとき' do
      it '入力されていなければコメントできない' do
        # ログインする
        sign_in(@user)
        # トップページに記事があることを確認
        expect(page).to have_content('title')
        # 記事詳細ページに遷移
        visit article_path(@article.id)
        # コメント欄にコメントを記入
        fill_in 'comment[content]', with: ''
        # コメントを送信しても保存されない
        expect  do
          find("input[name='commit']").click
        end.to change { Comment.count }.by(0)
        # 記事詳細ページにいることを確認する
        expect(current_path).to eq(article_path(@article.id))
      end
    end
  end
end
