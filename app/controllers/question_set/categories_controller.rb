class QuestionSet::CategoriesController < ApplicationController
  def index
    @active     = QuestionSet::Category.active.where_name_like(params[:keywords])
    @page       = (params[:page] || 0).to_i
    @page_size  = (params[:page_size] || 25).to_i
    @categories = @active.offset(@page_size * @page).limit(@page_size)
    # respond_with @categories, meta: { total_count: @active.count }

    respond_to do |format|
      format.html
      format.json { render json: @categories, meta: { total_count: @active.count } }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :max_question, :enable)
  end
end