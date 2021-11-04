class Admin::LabelsController < ApplicationController
  before_action :access_block_non_admin
  def index
    @labels = Label.all
    @label = Label.new
  end
  def new
    @label = Label.new
  end
  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:notice] = '新しいラベルを作成しました'
      redirect_to( admin_labels_path )
    else
      flash.now[:danger] = 'ラベルの作成に失敗しました'
      render :new
    end
  end
  def destroy
    @label = Label.find(params[:id])
    if @label.destroy
      flash[:notice] = 'ラベルを削除しました'
      redirect_to(admin_labels_path)
    else
      flash.now[:danger] = 'ラベルの削除に失敗しました'
      render :index
    end
  end
  private
    def label_params
      params.require(:label).permit(:label_name)
    end
end
