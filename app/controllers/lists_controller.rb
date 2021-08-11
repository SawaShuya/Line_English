class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show]

  def new
    @list = List.new
  end

  def index
    @lists = current_user.lists.order(id: "ASC")
  end

  def create
    @list = current_user.lists.new(list_params)
    @list.save
    redirect_to lists_path
  end

  def show
    @words = @list.words.order(id: "ASC")
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
