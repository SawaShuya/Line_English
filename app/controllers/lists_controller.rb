class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def new
    @list = List.new
  end

  def index
    @lists = current_user.lists.order(updated_at: "DESC")
  end

  def create
    @list = current_user.lists.new(list_params)
    @list.save
  end

  def show
    @words = @list.words.order(id: "ASC")
  end

  def edit
  end

  def update
    @list.update(list_params)
  end

  def destroy
    @list_id = @list.id
    @list.destroy
  end

  private
  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    @list = List.find(params[:id])
  end

  def check_user
    unless @list.user == current_user
      redirect_back(fallback_location: root_path)
    end
  end

end
