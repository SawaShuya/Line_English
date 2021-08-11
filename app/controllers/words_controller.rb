class WordsController < ApplicationController
  before_action :authenticate_user!

  def new
    @list = List.find(params[:list_id])
    @form = Form::WordCollection.new
  end

  def create
    @form = Form::WordCollection.new(word_collection_params)
    list = List.find(params[:list_id])
    if @form.save_for(list.id)
      redirect_to list_path(list)
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
  def word_collection_params
      params.require(:form_word_collection).permit(words_attributes: [:japanese, :english])
  end

end
