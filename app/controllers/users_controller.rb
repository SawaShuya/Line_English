class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.update(user_params)
    redirect_back(fallback_location: root_path)
  end


  def app_config
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:question_list_id, :question_limit, :is_remember_word_question, :is_question)
  end
end
