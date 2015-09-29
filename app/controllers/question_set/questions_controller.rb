class QuestionSet::QuestionsController < ApplicationController
  before_filter :authorized?

  def index
    @category = QuestionSet::Category.find(params[:category_id])
    @q = @category.questions.active.ransack(params[:q])
    @questions = @q.result.order("text").page(params[:page])
  end

  def search
    index
    render :index
  end

  def new
    @category = QuestionSet::Category.find(params[:category_id])
    @question = @category.questions.new
  end

  def edit
    @category = QuestionSet::Category.find(params[:category_id])
    @question = QuestionSet::Question.find(params[:id])
  end

  def show
    render json: QuestionSet::Question.find(params[:id])
  end

  def create
    @category = QuestionSet::Category.find(params[:category_id])

    if QuestionSet::Question.create(question_params)
      flash[:notice] = 'Question was successfully added.'
      render nothing: true, status: 204
    else
      render json: { errors: @question.errors.to_a }, status: :unprocessable_entity
    end
  end

  def update
    @question = QuestionSet::Question.find(params[:id])

    if @question.update(question_params)
      flash[:notice] = 'Question was successfully updated.'
      render nothing: true, status: 204
    else
      render json: { errors: @question.errors.to_a }, status: :unprocessable_entity
    end
  end

  # Archive a question
  def archive
    @category = QuestionSet::Category.find(params[:category_id])
    @question = QuestionSet::Question.find(params[:id])

    if @question.update_attributes(archived_at: DateTime.now)
      flash[:notice] = 'Question was successfully deleted.'
      redirect_to question_set_category_questions_path(@category)
    else
      render "index"
    end
  end

  private

  def question_params
    params.require(:question).permit(:text, :category_id, choices_attributes: [:id, :text, :answer, :_destroy])
  end
end