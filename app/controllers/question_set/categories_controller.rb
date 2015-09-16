class QuestionSet::CategoriesController < ApplicationController
  before_filter :authorized?

  def index
    @active     = QuestionSet::Category.active.where_name_like(params[:keywords])
    @page       = (params[:page] || 0).to_i
    @page_size  = (params[:page_size] || 25).to_i
    @categories = @active.offset(@page_size * @page).limit(@page_size).order("name")

    respond_to do |format|
      format.html
      format.json { render json: @categories, meta: { total_count: @active.count } }
    end
  end

  def show
    @category = QuestionSet::Category.find(params[:id])

    render json: @category
  end

  def new
  end

  def create
    @category = QuestionSet::Category.create(category_params)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      render json: { id: @category.id }
    else
      render json: { errors: @category.errors.to_a }, status: :unprocessable_entity
    end
  end

  def edit
    @category = QuestionSet::Category.find(params[:id])
  end

  def update
    @category = QuestionSet::Category.find(params[:id])

    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
      render nothing: true, status: 204
    else
      render json: { errors: @category.errors.to_a }, status: :unprocessable_entity
    end
  end

  # Archive a category
  def archive
    @category = QuestionSet::Category.find(params[:id])

    if @category.update_attributes(archived_at: DateTime.now)
      flash[:notice] = 'Category was successfully deleted.'
      render nothing: true, status: 204
    else
      render json: { errors: @category.errors.to_a }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :max_question, :enabled)
  end
end