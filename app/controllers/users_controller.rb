class UsersController < ApplicationController
  before_filter :authorized?

  def index
    @page = (params[:page] || 0).to_i
    @page_size = (params[:page_size] || 25).to_i
    @all_users = User.with_deleted.where_email_like(params[:keywords])
    @users = @all_users.offset(@page_size * @page).limit(@page_size).order("email")

    respond_to do |format|
      format.html
      format.json { render json: @users, meta: { total_count: @all_users.count } }
    end
  end

  def edit
    @user = User.with_deleted.find(params[:id])
  end

  def update
    @user = User.with_deleted.find(params[:id])
    params[:user][:deleted_at] = params[:deleted_at] ? DateTime.now : nil

    if @user.update_attributes(user_params)
      flash[:notice] = 'User was successfully updated.'
      render nothing: true, status: 204
    end
  end

  def results
    @user = User.find(params[:user_id])
    @exams = Exam::List.where(user: @user).order("category_id ASC, workflow_state ASC")

    respond_to do |format|
      format.html
      format.json { render json: @exams, root: false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :admin, :deleted_at, :first_name, :last_name)
  end
end