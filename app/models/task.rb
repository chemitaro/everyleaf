class Task < ApplicationRecord
  belongs_to :user
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 225 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validates :user_id, presence: true

  enum priority: ["低", "中", "高"]
  
  # scope :search, ->(params_select) {where('task_name like ?', "%#{params_select[:search]}%")}
  # scope :status, ->(params_select) do
  #   statuses = []
  #   statuses << "未着手" if params_select[:status_not] == "1"
  #   statuses << "着手中" if params_select[:status_working] == "1"
  #   statuses << "完了" if params_select[:status_fin] == "1"
  #   where(status: statuses)
  # end
  # scope :sort_index, ->(params_select) {order(params_select[:sort_index] => params_select[:direction].to_sym)}

  # scope :search, ->(params) do
  #   if params[:search].present? && params[:status].present?
  #     where('task_name like ?', "%#{params[:search]}%").where(status: params[:status].to_sym )
  #   elsif  params[:search].present?
  #     where('task_name like ?', "%#{params[:search]}%")
  #   elsif  params[:status].present?
  #     where(status: params[:status].to_sym )
  #   else
  #     all
  #   end
  # end

  scope :search_status, ->(params_search, params_status) {where('task_name like ?', "%#{params_search}%").where(status: params_status.to_sym )}
  scope :search, ->(params_search) {where('task_name like ?', "%#{params_search}%")}
  scope :status, ->(params_status) {where(status: params_status.to_sym )}

end
