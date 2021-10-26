require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task', content: 'content')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
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
        check '未着手'
        uncheck '着手中'
        uncheck '完了'
        click_on "表示する"
        expect(page).to have_content "task1"
        expect(page).to_not have_content "task2"
        expect(page).to_not have_content "task3"
      end
      it 'タイトルとステータスの両方で検索できる' do
        visit tasks_path
        fill_in "タスク名 検索：", with: "task1"
        click_on "表示する"
        check '未着手'
        uncheck '着手中'
        uncheck '完了'
        click_on "表示する"
        expect(page).to have_content "task1"
        expect(page).to_not have_content "task2"
        expect(page).to_not have_content "task3"
      end

    end
  end
end