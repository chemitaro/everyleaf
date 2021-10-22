# README

## DB
**Task**
>id
>task_name :string
>content :text
>priority :string
>status :string
>deadline :date
>user_id :reference
>timestamp

**User**
>id
>name :string
>email :string
>password_digest :string
>admin :boolean
>timestamp

**IntermediaryTaskLabel**
>id
>task_id :reference
>label_id :reference
>timestamp

**Label**
>id
>label
>timestamp


## Heroku デプロイ手順
- heroku login
- heroku create
  Creating app... done, ⬢ guarded-river-76835
  https://guarded-river-76835.herokuapp.com/ |https://git.heroku.com/guarded-river-76835.git
- git push heroku step2:master
- heroku run rails db:migrate
