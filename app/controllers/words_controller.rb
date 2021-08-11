class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:new, :create, :edit, :update]
  before_action :set_word, only: [:edit, :update, :destroy]

  def new
    @form = Form::WordCollection.new
  end

  def create
    @form = Form::WordCollection.new(word_collection_params)
    if @form.save_for(@list.id)
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @word.update(word_params)
  end

  def destroy
    @word_id = @word.id
    @word.destroy
  end

  private
  def word_collection_params
      params.require(:form_word_collection).permit(words_attributes: [:japanese, :english])
  end

  def word_params
    params.require(:word).permit(:japanese, :english)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_word
    @word = Word.find(params[:id])
  end


end
