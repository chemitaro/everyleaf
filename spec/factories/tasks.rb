FactoryBot.define do
  factory :task do
    task_name { 'task' }
    content {'content'}
    deadline {'2021-10-10 10:10:10'}
    status {'ĉŞçĉ'}
    priority {'ä½'}
    user_id {1}
  end
end
