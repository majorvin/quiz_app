class Exam::ListsController < ApplicationController
  before_filter :check_privileges, only: [:show, :update]

  def show
    @exam = Exam::List.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @exam }
    end
  end

  def find
    # TODO get the last and not finish
    @exam = Exam::List.find_or_create(current_user, params[:category_id])

    url = {"url" => exam_list_path(@exam)}
    render json: url.to_json
  end

  def update
    @exam = Exam::List.find(params[:id])
    @exam.submit! if @exam.can_submit?

    render nothing: true, status: 204
  end

  private

  def check_privileges
    exam = Exam::List.find(params[:id])

    if exam.user != current_user
      flash[:alert] = "You are not authorized to view that page."
      redirect_to available_path
    end
  end
end
