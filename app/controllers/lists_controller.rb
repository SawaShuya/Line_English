class ListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @list = List.new
  end

  def index
    @lists = current_user.lists
  end

  def create
    @list = current_user.lists.new(list_params)
    @list.save
    redirect_to lists_path
  end

  def show
    @list = List.find(params[:id])
    @words = @list.words
  end

  private
  def list_params
    params.require(:list).permit(:title)
  end

end
