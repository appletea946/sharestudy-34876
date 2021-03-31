require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録ができる' do
      it '正しい情報を入力すれば新規登録ができてトップページに遷移する' do
        # トップページに遷移する
        visit root_path
        # トップページに新規登録ボタンがあることを確認する
        expect(page).to have_content('新規登録')
        # 新規登録ページに遷移する
        visit new_user_registration_path
        # 正しい情報を入力する
        fill_in 'user[nickname]', with: @user.nickname
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        fill_in 'user[password_confirmation]', with: @user.password_confirmation
        # 登録ボタンを押すとusersのカウントが１上がることを確かめる
        expect  do
          find('input[name="commit"]').click
        end.to change { User.count }.by(1)
        # トップページに遷移することを確認する
        expect(current_path).to eq(root_path)
        # ログインボタンや新規登録ボタンがないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context '新規登録ができない' do
      it '誤った情報では新規登録できず新規登録ページに戻る' do
        # トップページに遷移する
        visit root_path
        # トップページに新規登録ボタンがあることを確認する
        expect(page).to have_content('新規登録')
        # 新規登録ページに遷移する
        visit new_user_registration_path
        # 誤った情報を入力する
        fill_in 'user[nickname]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        # 登録ボタンを押してもusersのカウントが上がらないことを確かめる
        expect  do
          find('input[name="commit"]').click
        end.to change { User.count }.by(0)
        # 新規登録ページに戻ったことを確かめる
        expect(current_path).to eq('/users')
      end
    end
  end
  describe 'ユーザーログイン' do
    context 'ログインができる' do
      it '正しい情報を入力するとログインができてトップページに遷移する' do
        @user.save
        # トップページに遷移する
        visit root_path
        # トップページにログインボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページに遷移する
        visit new_user_session_path
        # 正しい情報を入力する
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページに遷移することを確認する
        expect(current_path).to eq(root_path)
        # ログインボタンや新規登録ボタンがないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ログインができない' do
      it '誤った情報ではログインできずログインページに戻ってくる' do
        @user.save
        # トップページに遷移する
        visit root_path
        # トップページにログインボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページに遷移する
        visit new_user_session_path
        # 誤った情報を入力する
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページに戻ることを確かめる
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
  describe 'ユーザーログアウト' do
    context 'ログアウトができる' do
      it 'ログアウトボタンを押すとトップページに遷移する' do
        @user.save
        # トップページに遷移する
        visit root_path
        # トップページにログインボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページに遷移する
        visit new_user_session_path
        # 正しい情報を入力する
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページに遷移することを確認する
        expect(current_path).to eq(root_path)
        # トップページにログアウトボタンがあることを確かめる
        expect(page).to have_content('ログアウト')
        # ログアウトボタンを押す
        find('a[id="log_out"]').click
        # トップページに遷移したことを確かめる
        expect(current_path).to eq(root_path)
        # トップページにログインボタンがあることを確かめる
        expect(page).to have_content('ログイン')
      end
    end
  end
end
