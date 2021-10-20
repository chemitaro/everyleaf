# README

Task
  id
  task_name :string
  content :text
  priority :string #後で
  status :string #後で
  deadline :date #後で
  user_id :reference #後で
  timestamp

User #後で
  id
  name :string
  email :string
  password_digest :string
  admin :boolean
  timestamp

IntermediaryTaskLabel #後で
  id
  task_id :reference
  label_id :reference
  timestamp

Label #後で
  id
  label
  timestamp