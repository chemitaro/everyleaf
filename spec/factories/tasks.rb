FactoryBot.define do
  factory :task do
    task_name { 'task' }
    content {'content'}
    deadline {'2021-10-10 10:10:10'}
    status {'未着手'}
    priority {'低'}
    user_id {1}
  end
end
