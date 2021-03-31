require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.build(:group, user_id: @user.id)
  end

  describe 'グループ作成' do
    context '作成できるとき' do
      it '情報が正しく入力されていれば作成できる' do
        # ログインする
        sign_in(@user)
        # ユーザーの名前がトップページにあることを確認する
        expect(page).to have_content(@user.nickname)
        # ユーザー詳細ページに遷移する
        visit user_path(@user.id)
        # グループ一覧ページに行くためのリンクがある
        expect(page).to have_content('所属グループ')
        # グループ一覧ページに遷移する
        visit groups_path
        # グループ作成のリンクがあることを確認する
        expect(page).to have_content('作成')
        # グループ作成画面に遷移する
        visit new_group_path
        # 正しい情報を入力する
        fill_in 'users_group[name]', with: @group.name
        fill_in 'users_group[password]', with: @group.password
        # 作成ボタンを押すと、groupのカウントが１増える
        expect  do
          find("input[name='commit']").click
        end.to change { Group.count }.by(1)
        # グループ一覧画面に遷移することを確認する
        expect(current_path).to eq(groups_path)
      end
    end
    context '作成できないとき' do
      it '情報が正しく入力されていなければ作成できない' do
        # ログインする
        sign_in(@user)
        # ユーザーの名前がトップページにあることを確認する
        expect(page).to have_content(@user.nickname)
        # ユーザー詳細ページに遷移する
        visit user_path(@user.id)
        # グループ一覧ページに行くためのリンクがある
        expect(page).to have_content('所属グループ')
        # グループ一覧ページに遷移する
        visit groups_path
        # グループ作成のリンクがあることを確認する
        expect(page).to have_content('作成')
        # グループ作成画面に遷移する
        visit new_group_path
        # 誤った情報を入力する
        fill_in 'users_group[name]', with: ''
        fill_in 'users_group[password]', with: ''
        # 作成ボタンを押してもgroupは増えない
        expect  do
          find("input[name='commit']").click
        end.to change { Group.count }.by(0)
        # グループ一覧画面に遷移することを確認する
        expect(current_path).to eq('/groups')
      end
    end
  end
  describe 'グループ参加' do
    context '参加できるとき' do
      it 'パスワードが等しければ参加できる' do
        @group.save # 参加するグループ
        @user_group_relation = FactoryBot.create(:user_group_relation, user_id: @user.id, group_id: @group.id)
        participate_user = FactoryBot.create(:user) # グループに参加するユーザー
        # ログインする
        sign_in(participate_user)
        # ユーザー詳細ページに遷移する
        visit user_path(participate_user.id)
        # グループ一覧ページに遷移する
        visit groups_path
        # グループ一覧に@groupのnameがあることを確認する
        expect(page).to have_content(@group.name)
        # グループの詳細ページに行くとパスワード入力を求める画面に遷移する
        find_link(@group.name, href: "/groups/sign_up.#{@group.id}").click
        # パスワード入力を求める画面に遷移するを確認
        expect(current_path).to eq("/groups/sign_up.#{@group.id}")
        # 正しいパスワードを入力
        fill_in 'password', with: @group.password
        # 参加ボタンを押すとUserGroupRelationのカウントが１増える
        expect  do
          find("input[name='commit']").click
        end.to change { UserGroupRelation.count }.by(1)
        # 参加できるとそのグループの詳細画面に遷移することを確認する
        expect(current_path).to eq(group_path(@group.id))
      end
    end
    context '参加できないとき' do
      it "\bパスワードが等しくなければ参加できない" do
        @group.save # 参加するグループ
        @user_group_relation = FactoryBot.create(:user_group_relation, user_id: @user.id, group_id: @group.id)
        participate_user = FactoryBot.create(:user) # グループに参加するユーザー
        # ログインする
        sign_in(participate_user)
        # ユーザー詳細ページに遷移する
        visit user_path(participate_user.id)
        # グループ一覧ページに遷移する
        visit groups_path
        # グループ一覧に@groupのnameがあることを確認する
        expect(page).to have_content(@group.name)
        # グループの詳細ページに行くとパスワード入力を求める画面に遷移する
        find_link(@group.name, href: "/groups/sign_up.#{@group.id}").click
        # パスワード入力を求める画面に遷移することを確認
        expect(current_path).to eq("/groups/sign_up.#{@group.id}")
        # 誤ったパスワードを入力
        fill_in 'password', with: "#{@group.password}group"
        # 参加ボタンを押してもUserGroupRelationのカウントが増えない
        expect  do
          find("input[name='commit']").click
        end.to change { UserGroupRelation.count }.by(0)
        # パスワード入力を求める画面に遷移していることを確認する
        expect(current_path).to eq("/groups/sign_up.#{@group.id}")
      end
    end
  end
end
