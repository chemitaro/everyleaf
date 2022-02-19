class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 225 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validates :user_id, presence: true

  enum priority: ["低", "中", "高"]
  
  scope :search_status, ->(params_search, params_status) {where('task_name like ?', "%#{params_search}%").where(status: params_status.to_sym )}
  scope :search, ->(params_search) {where('task_name like ?', "%#{params_search}%")}
  scope :status, ->(params_status) {where(status: params_status.to_sym )}
  scope :label, ->(params_label_id) do
    
    where(task_name: '')
  end

end
