# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{id: 1, name: 'Admin', email: 'admin@email.com', password: 'password', admin: true}])

Task.create([{task_name: 'task', content: 'content', status: '未着手', priority: '低', deadline: '2022-11-01 21:21:21', user_id: 1}])