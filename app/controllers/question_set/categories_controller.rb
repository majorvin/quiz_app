class QuestionSet::CategoriesController < ApplicationController
  before_filter :authorized?, except: [:exam_list, :results]

  def index
    @q = QuestionSet::Category.active.ransack(params[:q])
    @categories = @q.result.order("name").page(params[:page])
  end

  def show
    @category = QuestionSet::Category.find(params[:id])
    @questions = @category.questions.order("text").page(params[:page])
  end

  def new
    @category = QuestionSet::Category.new
  end

  def create
    @category = QuestionSet::Category.create(category_params)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to question_set_category_questions_path(@category)
    else
      render "new"
    end
  end

  def edit
    @category = QuestionSet::Category.find(params[:id])
  end

  def update
    @category = QuestionSet::Category.find(params[:id])

    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to question_set_category_questions_path(@category)
    else
      render "edit"
    end
  end

  # Archive a category
  def archive
    @category = QuestionSet::Category.find(params[:id])

    if @category.update_attributes(archived_at: DateTime.now)
      flash[:notice] = 'Category was successfully deleted.'
      redirect_to question_set_categories_path
    else
      render "index"
    end
  end

  def results
    @category = QuestionSet::Category.find(params[:category_id])
    @exams = Exam::List.where("category_id = ? AND user_id = ?", @category.id, current_user.id)

    respond_to do |format|
      format.html
      format.json { render json: @exams, root: false }
    end
  end

  def exam_list
    @track = current_user.track
    @active = @track.categories.active
    @enabled = @active.enabled.where_name_like(params[:keywords])
    @page = (params[:page] || 0).to_i
    # TODO change the page size or create pagination
    @page_size  = (params[:page_size] || 10000).to_i
    @categories = @enabled.offset(@page_size * @page).limit(@page_size).order("name")

    respond_to do |format|
      format.html
      format.json {
        render json: @categories,
               each_serializer: QuestionSet::CategoryAvailableSerializer,
               meta: { total_count: @enabled.count }
      }
    end
  end

  private

  def category_params
    params.require(:question_set_category).permit(:name, :max_question, :enabled)
  end
end