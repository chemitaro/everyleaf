class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 225 }
  validates :deadline, presence: true
  validates :status, presence: true
  
  scope :search, ->(params_select) {where('task_name like ?', "%#{params_select[:search]}%")}
  scope :status, ->(params_select) do
    statuses = []
    statuses << "未着手" if params_select[:status_not] == "1"
    statuses << "着手中" if params_select[:status_working] == "1"
    statuses << "完了" if params_select[:status_fin] == "1"
    where(status: statuses)
  end
  scope :sort_index, ->(params_select) {order(params_select[:sort_index] => params_select[:direction].to_sym)}
end
