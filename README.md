# README

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