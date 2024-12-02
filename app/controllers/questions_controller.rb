class QuestionsController < ApplicationController
  def show
    @question = Question.find(params.expect(:id))
    @user = User.find_by(id: session[:user_id])
    @answer = Answer.find_or_initialize_by(question: @question, user: @user)

    redirect_to new_user_path if @user.nil?
  end
end
