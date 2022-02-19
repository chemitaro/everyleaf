# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{name: 'Admin', email: 'admin@email.com', password: 'password', admin: true},
              {name: 'Taro', email: 'taro@email.com', password: 'password', admin: false},
              {name: 'Jiro', email: 'jiro@email.com', password: 'password', admin: false},
              {name: 'Saburo', email: 'saburo@email.com', password: 'password', admin: false},
              {name: 'Shiro', email: 'shiro@email.com', password: 'password', admin: false},
              {name: 'Goro', email: 'goro@email.com', password: 'password', admin: false},
              {name: 'Rakuro', email: 'rokuro@email.com', password: 'password', admin: false},
              {name: 'Nanaro', email: 'nanaro@email.com', password: 'password', admin: false},
              {name: 'Hachiro', email: 'hachiro@email.com', password: 'password', admin: false},
              {name: 'Kyuro', email: 'kyuro@email.com', password: 'password', admin: false},])

Task.create([{task_name: '起きる', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '顔を洗う', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '歯を磨く', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '着替える', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '朝食を作る', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '朝食を食べる', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: 'ニュースを見る', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '荷物を整える', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '髪型を整える', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id},
              {task_name: '家を出る', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: User.first.id}])

Label.create([{label_name: '開発業務'}, 
              {label_name: '実用テスト'}, 
              {label_name: '生産'}, 
              {label_name: '品質改良'}, 
              {label_name: 'クレーム対応'},
              {label_name: '料理'},
              {label_name: '勉強'},
              {label_name: '生活の知恵'},
              {label_name: '感動'},
              {label_name: 'イイネ'},])

Labeling.create([{task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id},
                  {task_id: Task.first.id, label_id: Label.first.id}])