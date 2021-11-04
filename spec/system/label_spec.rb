require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    FactoryBot.create(:user,id: 1, name: 'user', email: 'user@email.com', password: 'password', admin: false)
    visit new_session_path
    fill_in "メールアドレス",	with: 'user@email.com'
    fill_in "パスワード", with: 'password'
    click_button "ログイン"
  end
  describe 'ラベル機能の付与、表示、検索の確認' do
    before do
      FactoryBot.create(:label, id: 1, label_name: 'label')
      FactoryBot.create(:label, id: 2, label_name: 'tag')
    end
    context '新規タスクを登録した場合' do
      it '作成したタスクの詳細画面にラベルが表示される' do
        visit new_task_path
        fill_in "タスク名",	with: "test"
        fill_in "内容",	with: "content"
        check 'label'
        click_button "登録する"
        expect(page).to have_content 'label'
      end
    end
    context '既存タスクを編集した場合' do
      before do
        visit new_task_path
        fill_in "タスク名",	with: "test"
        fill_in "内容",	with: "content"
        check 'label'
        click_button "登録する"
      end
      it '編集したタスクの詳細画面にラベルが表示される' do
        visit tasks_path
        click_on '編集'
        uncheck 'label'
        check 'tag'
        click_button '編集する'
        expect(page).to have_content 'tag'
        expect(page).to_not have_content 'label'
      end
    end
    context "ラベル検索をした場合" do
      before do
        visit new_task_path
        fill_in "タスク名", with: "task"
        fill_in "内容", with: "content"
        check 'label'
        uncheck 'tag'
        click_button '登録する'
        visit new_task_path
        fill_in "タスク名", with: "sample"
        fill_in "内容", with: "content"
        check 'tag'
        uncheck 'label'
        click_button '登録する'
      end
      it '検索したラベルの付いたタスクが表示される' do
        visit tasks_path
        select 'label', from: 'select_label_id'
        click_button '表示する'
        expect(page).to have_content 'task'
        expect(page).to_not have_content 'sample'
      end
    end
  end
end