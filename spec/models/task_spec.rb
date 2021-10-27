require 'rails_helper'

RSpec.describe 'タスクのモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', content: '失敗テスト', status: '未着手', priority: '低', deadline: '2021-10-27 05:10:00')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: '失敗テスト', content: '', status: '未着手', priority: '低', deadline: '2021-10-27 05:10:00')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: '合格テスト', content: '合格内容', status: '未着手', priority: '低', deadline: '2021-10-27 05:10:00')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    before do
      @task = FactoryBot.create(:task, task_name: 'task', content: 'content', status: '未着手', priority: '低', deadline: '2021-10-27 05:10:00')
      @second_task = FactoryBot.create(:task, task_name: "sample", content: 'content', status: '完了', priority: '低', deadline: '2021-10-27 05:10:00')
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search('task')).to include(@task)
        expect(Task.search('task')).not_to include(@second_task)
        expect(Task.search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.status('未着手')).to include(@task)
        expect(Task.status('未着手')).not_to include(@second_task)
        expect(Task.status('未着手').count).to eq 1

      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search_status('task', '未着手')).to include(@task)
        expect(Task.search_status('task', '未着手')).not_to include(@second_task)
        expect(Task.search_status('task', '未着手').count).to eq 1
      end
    end
  end

end