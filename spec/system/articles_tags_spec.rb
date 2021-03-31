require 'rails_helper'

RSpec.describe 'ArticlesTags', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group, user_id: @user.id)
    @tag = FactoryBot.create(:tag)
    @article = FactoryBot.build(:article, user_id: @user.id)
  end

  describe '記事投稿機能' do
    context '新規登録ができる' do
      it '正しい情報を入力すれば新規登録ができてトップページに遷移する' do
        # ログインする
        sign_in(@user)
        # トップページに投稿画面に遷移するリンクがある
        expect(page).to have_content('作成')
        # 記事投稿画面に遷移する
        visit new_article_path
        # 正しい情報を入力する
        fill_in 'articles_tag[title]', with: @article.title
        fill_in 'articles_tag[name]', with: @tag.name
        fill_in 'articles_tag[content]', with: @article.content
        # 投稿ボタンを押すとArticleのカウントが１上がる
        expect  do
          find("input[name='commit']").click
        end.to change { Article.count }.by(1)
        # トップページに遷移していること確認する
        expect(current_path).to eq(root_path)
      end
    end
  end
  context '新規登録ができない' do
    it '誤った情報を入力すると新規登録ができず、記事投稿画面に戻る' do
      # ログインする
      sign_in(@user)
      # トップページに投稿画面に遷移するリンクがある
      expect(page).to have_content('作成')
      # 記事投稿画面に遷移する
      visit new_article_path
      # 正しい情報を入力する
      fill_in 'articles_tag[title]', with: ''
      fill_in 'articles_tag[name]', with: ''
      fill_in 'articles_tag[content]', with: ''
      # 投稿ボタンを押すとArticleのカウントが１上がる
      expect  do
        find("input[name='commit']").click
      end.to change { Article.count }.by(0)
      # 記事投稿画面に戻っていることを確認
      expect(current_path).to eq('/articles')
    end
  end

  describe '記事編集機能' do
    context '記事編集ができる' do
      it '正しい情報を入力すれば記事編集ができて記事詳細ページに遷移する' do
        @article.save
        # ログインする
        sign_in(@user)
        # 記事があるか確認する
        expect(page).to have_content('title')
        # 記事詳細ページに遷移する
        visit article_path(@article.id)
        # 記事編集ページに遷移するリンクがあることを確認する
        expect(page).to have_content('編集')
        # 記事編集ページに遷移する
        visit edit_article_path(@article.id)
        # 保存ボタンを押すと編集できて記事詳細画面に遷移する
        find("input[name='commit']").click
        # 記事詳細画面にいることを確認する
        expect(current_path).to eq(article_path(@article.id))
      end
    end
  end
  context '記事編集ができない' do
    it '誤った情報を入力すると記事編集ができず記事編集ページに戻る' do
      @article.save
      # ログインする
      sign_in(@user)
      # 記事があるか確認する
      expect(page).to have_content('title')
      # 記事詳細ページに遷移する
      visit article_path(@article.id)
      # 記事編集ページに遷移するリンクがあることを確認する
      expect(page).to have_content('編集')
      # 記事編集ページに遷移する
      visit edit_article_path(@article.id)
      # 誤った情報を入力する
      fill_in 'article[title]', with: ''
      fill_in 'article[content]', with: ''
      # 保存ボタンを押すとできずに編集画面に戻ってくる
      find("input[name='commit']").click
      # 記事編集画面にいることを確認する
      expect(current_path).to eq("/articles/#{@article.id}")
    end
  end
end
