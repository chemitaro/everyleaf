require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:user,id: 1, name: 'user', email: 'user@email.com', password: 'password', admin: false)
    visit new_session_path
    fill_in "メールアドレス",	with: 'user@email.com'
    fill_in "パスワード", with: 'password'
    click_button "ログイン"
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タスク名", with: 'test_task'
        fill_in "内容", with: 'test_content'
        #終了期限の登録を追記
        select '2021', from:'task_deadline_1i'
        select '10月', from:'task_deadline_2i'
        select '26', from:'task_deadline_3i'
        select '17', from:'task_deadline_4i'
        select '15', from:'task_deadline_5i'
        #ステータスの登録を追記
        select '未着手', from:'task_status'
        click_on "登録する"
        expect(page).to have_content 'test_task'
        expect(page).to have_content 'test_content'
        #終了期限の確認
        expect(page).to have_content '2021年10月26日 17:15'
        #ステータスの確認
        expect(page).to have_content '未着手'
      end
    end
    context 'タスク名の文字数オーバーの場合' do
      it 'エラーメッセージが表示される'do
        visit new_task_path
        fill_in "タスク名", with: "#{'a' * 105} "
        click_on "登録する"
        expect(page).to have_content 'error'
      end
    end
    context '内容の文字数オーバーの場合' do
      it 'エラーメッセージが表示される'do
        visit new_task_path
        fill_in "タスク名", with: 'test'
        fill_in "内容", with: "#{'a' * 256}"
        click_on "登録する"
        expect(page).to have_content 'error'
      end
    end 
    context 'タスク名が空欄の場合' do
      it 'エラーメッセージが表示される'do
        visit new_task_path
        fill_in "内容", with: 'test_content'
        click_on "登録する"
        expect(page).to have_content 'error'
      end
    end 
    context '内容が空欄の場合' do
      it 'エラーメッセージが表示される'do
        visit new_task_path
        fill_in "タスク名", with: 'test_task'
        click_on "登録する"
        expect(page).to have_content 'error'
      end
    end 
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task, task_name: 'task1', content: 'content', status:'未着手', priority: '低', deadline: '2021-10-27 04:05:00',user_id: 1)
      FactoryBot.create(:task, task_name: 'task2', content: 'content', status:'着手中', priority: '中', deadline: '2021-10-28 04:05:00',user_id: 1)
      FactoryBot.create(:task, task_name: 'task3', content: 'content', status:'完了', priority: '高', deadline: '2021-10-29 04:05:00',user_id: 1)

    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task1'
        expect(page).to have_content 'task2'
        expect(page).to have_content 'task3'
      end
    end
    context '終了期限でソートするというリンクを押すと' do
      it '作成したタスクが表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        first_table = all('tbody tr')[1]
        second_table = all('tbody tr')[2]
        third_table = all('tbody tr')[3]
        expect(first_table).to have_content '2021年10月29日'
        expect(second_table).to have_content '2021年10月28日'
        expect(third_table).to have_content '2021年10月27日'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, task_name: 'task', content: 'content')
        visit task_path(Task.last.id)
        expect(page).to have_content Task.last.task_name
        expect(page).to have_content Task.last.content
      end
    end
  end
  describe '検索機能' do
    context '検索した場合' do
      before do
        visit new_task_path
        fill_in "タスク名",	with: "task1"
        fill_in "内容",	with: "content"
        select '未着手', from:'task_status'
        click_on "登録する"
        visit new_task_path
        fill_in "タスク名",	with: "task2"
        fill_in "内容",	with: "content"
        select '着手中', from:'task_status'
        click_on "登録する"
        visit new_task_path
        fill_in "タスク名",	with: "task3"
        fill_in "内容",	with: "content"
        select '完了', from:'task_status'
        click_on "登録する"
      end
      it 'タイトルで検索できる' do
        visit tasks_path
        fill_in "タスク名 検索：", with: "task1"
        click_on "表示する"
        expect(page).to have_content "task1"
        expect(page).to_not have_content "task2"
        expect(page).to_not have_content "task3"
      end
      it 'ステータスで検索できる' do
        visit tasks_path
        select '未着手', from:'select_status'
        click_on "表示する"
        expect(page).to have_content "task1"
        expect(page).to_not have_content "task2"
        expect(page).to_not have_content "task3"
      end
      it 'タイトルとステータスの両方で検索できる' do
        visit tasks_path
        fill_in "タスク名 検索：", with: "task1"
        select '未着手', from:'select_status'
        click_on "表示する"
        expect(page).to have_content "task1"
        expect(page).to_not have_content "task2"
        expect(page).to_not have_content "task3"
      end
    end
  end
  describe 'ラベル機能' do
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