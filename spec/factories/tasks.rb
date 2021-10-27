FactoryBot.define do
  factory :task do
    task_name { 'task' }
    content {'content'}
    deadline {'2021-10-10 10:10:10'}
    status {'未着手'}
    priority {'低'}
  end
  factory :second_task do
    task_name { 'sample' }
    content {'content'}
    deadline {'2021-10-10 10:10:10'}
    status {'未着手'}
    priority {'低'}
  end

end
