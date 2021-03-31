require 'rails_helper'

RSpec.describe 'LikeUsers', type: :system do
  before do
    @give_user = FactoryBot.create(:user, nickname: 'するがわ')
    @receive_user = FactoryBot.create(:user, nickname: 'されるがわ')
    @article = FactoryBot.create(:article, user_id: @receive_user.id)
    @like_user = FactoryBot.build(:like_user, give_user: @give_user.id, receive_user: @receive_user.id)
  end
  describe 'お気に入り登録機能' do
    context 'お気に入り登録できるとき' do
      it 'お気に入り登録ボタンをクリックすればお気に入りできる' do
        # @give_userでログインする
        sign_in(@give_user)
        # 記事詳細ページに遷移する
        visit article_path(@article.id)
        # 記事投稿者の名前があることを確認する
        expect(page).to have_link(@article.user.nickname)
        # 記事投稿者の詳細ページに遷移する
        visit user_path(@article.user.id)
        # お気に入り登録ボタンがあることを確認する
        expect(page).to have_content('お気に入り登録')
        # お気に入り登録ボタンを押すとLikeUserのカウントが１増える
        expect do
          click_link('お気に入り登録')
        end.to change { LikeUser.count }.by(1)
        # ユーザー詳細ページにいることを確認する
        expect(current_path).to eq(user_path(@article.user.id))
        # ユーザー詳細ページにお気に入り解除ボタンがあることを確認する
        expect(page).to have_content('お気に入り解除')
      end
    end
    context 'お気に入り登録できないとき' do
      it '自分自身をお気に入り登録することはできない' do
        # @give_userでログインする
        sign_in(@receive_user)
        # 記事詳細ページに遷移する
        visit article_path(@article.id)
        # 記事投稿者の名前があることを確認する
        expect(page).to have_link(@article.user.nickname)
        # 記事投稿者の詳細ページに遷移する
        visit user_path(@article.user.id)
        # お気に入りボタンがないことを確認する
        expect(page).to have_no_content('お気に入り登録')
      end
    end
  end
  describe 'お気に入り解除機能' do
    context 'お気に入り解除できるとき' do
      it 'お気に入り解除ボタンをクリックすればお気に入り解除できる' do
        @like_user.save
        # @give_userでログインする
        sign_in(@give_user)
        # 記事詳細ページに遷移する
        visit article_path(@article.id)
        # 記事投稿者の名前があることを確認する
        expect(page).to have_link(@article.user.nickname)
        # 記事投稿者の詳細ページに遷移する
        visit user_path(@article.user.id)
        # お気に入り解除ボタンがあることを確認する
        expect(page).to have_content('お気に入り解除')
        # お気に入り解除ボタンを押すとLikeUserのカウントが1へる
        expect do
          click_link('お気に入り解除')
        end.to change { LikeUser.count }.by(-1)
        # ユーザー詳細ページにいることを確認する
        expect(current_path).to eq(user_path(@article.user.id))
        # ユーザー詳細ページにお気に入り登録ボタンがあることを確認する
        expect(page).to have_content('お気に入り登録')
      end
    end
  end
end
