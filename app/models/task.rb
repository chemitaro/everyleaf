class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :content, length: {maximum: 225}
end
