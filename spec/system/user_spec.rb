require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録' do
    context '未ログイン状態の時に' do
      it 'ユーザの新規登録ができること' do
        visit new_user_path
        fill_in 'ユーザー名', with:'user'
        fill_in 'メールアドレス', with:'user@email.com'
        fill_in 'パスワード', with:'password'
        fill_in 'user_password_confirmation', with:'password'
        click_button '登録する'
      end
      it 'タスク一覧画面に飛ぼうとするとログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).not_to have_content 'タスク一覧'
      end
    end
  end
  describe 'セッション機能' do
    context '未ログイン状態の時に' do
      before do
        FactoryBot.create(:user, name: 'user', email: 'user@email.com', password: 'password', admin: false)
      end
      it 'ログインができること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'user@email.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
      end
    end
    context '一般ユーザーとしてログインしている時に' do
      before do
        FactoryBot.create(:user, id: 1, name: 'user', email: 'user@email.com', password: 'password', admin: false)
        FactoryBot.create(:user, id: 2, name: 'another', email: 'another@email.com', password: 'password', admin: false)
        visit new_session_path
        fill_in 'メールアドレス', with: 'user@email.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
        
      it '自分の詳細画面(マイページ)に飛べること' do
        visit user_path(1)
        expect(page).to have_content 'さんのプロフィール詳細'
        expect(page).not_to have_content '不正なアクセスです'
      end
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        visit user_path(2)
        expect(page).not_to have_content 'さんのプロフィール詳細'
        expect(page).to have_content '不正なアクセスです'
      end
      it 'ログアウトができること' do
        visit tasks_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理者機能' do
    before do
      FactoryBot.create(:user, id: 1, name: 'admin', email: 'admin@email.com', password: 'password', admin: true)
      FactoryBot.create(:user, id: 2, name: 'user', email: 'user@email.com', password: 'password', admin: false)
    end
    context '一般ユーザーとしてログインしている時に' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'user@email.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'  
      end
      it '管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(page).to have_content '不正なアクセスです'
      end
    end
    context '管理ユーザーとしてログインしている時に' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@email.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
      it '管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content '管理者メニュー'  
      end
      it 'ユーザの新規登録ができること' do
        visit new_admin_user_path
        fill_in 'ユーザー名', with:'test'
        fill_in 'メールアドレス', with:'test@email.con'
        fill_in 'パスワード', with:'password'
        fill_in 'user_password_confirmation', with:'password'
        click_button '登録する'
        expect(page).to have_content '新しいユーザーを作成しました'
      end
      it 'ユーザの詳細画面にアクセスできること' do
        visit admin_user_path(2)
        expect(page).to have_content 'userさんのタスク一覧'
      end
      it 'ユーザの編集画面からユーザを編集できること' do
        visit edit_admin_user_path(2)
        fill_in 'ユーザー名', with:'taro'
        fill_in 'メールアドレス', with:'taro@email.com'
        fill_in 'パスワード', with:'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button '更新する'
        expect(page).to have_content 'ユーザー情報を更新しました'
      end
      it 'ユーザの削除をできること' do
        visit admin_users_path
        click_on '削除'
        accept_confirm
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
    
  end
end

