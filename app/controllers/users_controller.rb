class UsersController < ApplicationController
  before_filter :authorized?

  def index
    @page = (params[:page] || 0).to_i
    @page_size = (params[:page_size] || 10).to_i
    @all_users = User.with_deleted.where_email_like(params[:keywords])
    @users = @all_users.offset(@page_size * @page).limit(@page_size).order("email")

    respond_to do |format|
      format.html
      format.json { render json: @users, meta: { total_count: @all_users.count } }
    end
  end
end