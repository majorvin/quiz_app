class QuestionSet::QuestionsController < ApplicationController
  # def index
  #   @active     = QuestionSet::Question.active
  #   @category_questions = @active.by_category_id(params[:category_id]).where_text_like(params[:keywords])
  #   @page       = (params[:page] || 0).to_i
  #   @page_size  = (params[:page_size] || 10).to_i
  #   @questions  = @category_questions.offset(@page_size * @page).limit(@page_size)

  #   respond_with @questions, meta: { total_count: @category_questions.count }
  # end

  def show
    render json: QuestionSet::Question.find(params[:id])
  end

  def create
    @question =  QuestionSet::Question.create(question_params)

    if @question.save
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

  # # Archive a question
  # def archive
  #   @question = QuestionSet::Question.find(params[:id])

  #   if @question.update_attributes(archived_at: DateTime.now)
  #     render nothing: true, status: 204
  #   else
  #     render json: { errors: @question.errors.to_a }, status: :unprocessable_entity
  #   end
  # end

  # private

  def question_params
    params.require(:question).permit(:text, :category_id, choices_attributes: [:id, :text, :answer, :_destroy])
  end
end