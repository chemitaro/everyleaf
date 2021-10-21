require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        # 2. 新規登録内容を入力する
        fill_in "タスク名", with: 'test_task'
        fill_in "内容", with: 'test_content'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        click_on "登録する"
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        expect(page).to have_content 'test_task'
        expect(page).to have_content 'test_content'
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
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task')
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
end