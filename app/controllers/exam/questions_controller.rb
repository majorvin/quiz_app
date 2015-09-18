class Exam::QuestionsController < ApplicationController
  before_filter :check_priviledges, only: [:update]

  def update
    @question = Exam::Question.find(params[:id])
    @list = @question.list

    @list.start! if @list.created?

    if @question.update_attributes(question_params)
      render nothing: true, status: 204
    end
  end

  private

  def question_params
    params.require(:question).permit(:value)
  end

  def check_priviledges
    exam = Exam::Question.find(params[:id]).list

    if exam.user != current_user
      flash[:alert] = "You are not authorized to view that page."
      redirect_to available_path
    end
  end
end
