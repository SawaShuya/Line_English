class ListsController < ApplicationController

  def new
    @list = List.new
  end

  def index
    @lists = List.all
  end

  def create
    @list = List.new(list_params)
    @list.save
    redirect_to root_path
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
