# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{id: 1, name: 'Admin', email: 'admin@email.com', password: 'password', admin: true},
              {id: 2, name: 'Taro', email: 'taro@email.com', password: 'password', admin: false},
              {id: 3, name: 'Jiro', email: 'jiro@email.com', password: 'password', admin: false},
              {id: 4, name: 'Saburo', email: 'saburo@email.com', password: 'password', admin: false},
              {id: 5, name: 'Shiro', email: 'shiro@email.com', password: 'password', admin: false},
              {id: 6, name: 'Goro', email: 'goro@email.com', password: 'password', admin: false},
              {id: 7, name: 'Rakuro', email: 'rokuro@email.com', password: 'password', admin: false},
              {id: 8, name: 'Nanaro', email: 'nanaro@email.com', password: 'password', admin: false},
              {id: 9, name: 'Hachiro', email: 'hachiro@email.com', password: 'password', admin: false},
              {id: 10, name: 'Kyuro', email: 'kyuro@email.com', password: 'password', admin: false},])

Task.create([{id: 1, task_name: '起きる', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 2, task_name: '顔を洗う', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 3, task_name: '歯を磨く', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 4, task_name: '着替える', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 5, task_name: '朝食を作る', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 6, task_name: '朝食を食べる', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 7, task_name: 'ニュースを見る', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 8, task_name: '荷物を整える', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 9, task_name: '髪型を整える', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1},
              {id: 10, task_name: '家を出る', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1}])

Label.create([{id: 1, label_name: '開発業務'}, 
              {id: 2, label_name: '実用テスト'}, 
              {id: 3, label_name: '生産'}, 
              {id: 4, label_name: '品質改良'}, 
              {id: 5, label_name: 'クレーム対応'},
              {id: 6, label_name: '料理'},
              {id: 7, label_name: '勉強'},
              {id: 8, label_name: '生活の知恵'},
              {id: 9, label_name: '感動'},
              {id: 10, label_name: 'イイネ'},])

Labeling.create([{task_id: 1, label_id: 1},
                  {task_id: 2, label_id: 2},
                  {task_id: 3, label_id: 3},
                  {task_id: 4, label_id: 4},
                  {task_id: 5, label_id: 5},
                  {task_id: 6, label_id: 6},
                  {task_id: 7, label_id: 7},
                  {task_id: 8, label_id: 8},
                  {task_id: 9, label_id: 9},
                  {task_id: 10, label_id: 10}])