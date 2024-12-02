class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    redirect if @answer.save
  end

  def update
    @answer = Answer.find_by(question_id: answer_params[:question_id], user_id: answer_params[:user_id])
    @answer.update(value: answer_params[:value])
    redirect if @answer.save
  end

private

  def redirect
    if @answer.question.last?
      redirect_to user_path(@answer.user)
    else
      redirect_to question_path(@answer.question.next)
    end
  end

  def answer_params
    params.expect(answer: %i[value question_id user_id])
  end
end
