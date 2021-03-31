require 'rails_helper'

RSpec.describe 'LikeArticles', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @post_user.id)
    @like_article = FactoryBot.build(:like_article, user_id: @user.id, article_id: @article.id)
  end

  describe '記事お気に入り登録機能' do
    context 'お気に入り登録できる時' do
      it '記事お気に入りボタンを押すとお気に入り登録できる' do
        # ログインする
        sign_in(@user)
        # 記事詳細画面に遷移する
        visit article_path(@article.id)
        # 記事お気に入り登録ボタンがあることを確認する
        expect(page).to have_selector '.article-like-btn', text: 'お気に入り登録'
        # 記事お気に入り登録ボタンを押すと、LikeArticleのカウントが１増える
        expect do
          find("a[href='/articles/#{@article.id}/like_articles']").click
        end.to change { LikeArticle.count }.by(1)
        # 記事詳細画面に戻ることを確認する
        expect(current_path).to eq(article_path(@article.id))
      end
    end

    context 'お気に入り登録できない時' do
      it '自分の記事はお気に入り登録できない' do
        # ログインする
        sign_in(@post_user)
        # 記事詳細画面に遷移する
        visit article_path(@article.id)
        # 記事お気に入り登録ボタンがないことを確認する
        expect(page).to have_no_selector '.article-like-btn', text: 'お気に入り登録'
      end
    end
  end
  describe '記事お気に入り解除機能' do
    context 'お気に入り解除できる時' do
      it 'お気に入り解除ボタンを押すとお気に入り解除できる' do
        @like_article.save
        # ログインする
        sign_in(@user)
        # 記事詳細画面に遷移する
        visit article_path(@article.id)
        # 記事お気に入り解除ボタンがあることを確認する
        expect(page).to have_selector '.article-like-btn', text: 'お気に入り削除★'
        # 記事お気に入り解除ボタンを押すと、LikeArticleのカウントが１へる
        expect do
          find("a[href='/articles/#{@article.id}/like_articles/#{@article.id}']").click
        end.to change { LikeArticle.count }.by(-1)
        # 記事詳細画面に戻ることを確認する
        expect(current_path).to eq(article_path(@article.id))
      end
    end
  end
end
