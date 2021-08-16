class QuestionsController < ApplicationController
  before_action :set_variable, only: [:index]
  def index
  end

  def result
  end

  private
  def set_variable
    if params[:test_list].present? && params[:word_limit].present? && params[:word_status].present?
      @list = List.find(params[:test_list])
      if params[:word_status]
        @words = @list.words.where(is_remembered: false).sample(params[:word_limit].to_i)
      else
        @words = @list.words.sample(params[:word_limit].to_i)
    else 
      redirect_back(fallback_location: root_path)
    end
  end
end
