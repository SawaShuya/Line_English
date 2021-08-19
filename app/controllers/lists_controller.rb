class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def new
    @list = List.new
  end

  def index
    @lists = current_user.lists.sort{|a, b| b.last_update <=> a.last_update}
  end

  def create
    @list = current_user.lists.new(list_params)
    @list.save
    if current_user.question_list_id.nil?
      current_user.update(question_list_id: @list.id)
    end
  end

  def show
    @words = @list.words.order(id: "ASC")
  end

  def edit
  end

  def update
    if @list.title == params[:list][:title]
      @list.touch
    else
      @list.update(list_params)
    end
  end

  def destroy
    @list_id = @list.id
    @list.destroy
    if @list_id == current_user.question_list_id
      current_user.update(question_list_id: nil)
    end
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
