class Certification::CategoriesController < ApplicationController
  before_filter :authorized?

  def new
    @track = Certification::Track.find(params[:track_id])
    @categories = QuestionSet::Category.all
  end

  def batch_destroy
    @track = Certification::Track.find(params[:track_id])

    params["category"].each do |id|
      category = QuestionSet::Category.find(id)
      @track.categories.delete(category)
    end

    flash[:notice] = "#{params['category'].count} categories have been removed."
    redirect_to certification_track_path(@track)
  end

  def batch_update
    @track = Certification::Track.find(params[:track_id])
    @categories = []

    params["category"].each do |id|
      @categories << QuestionSet::Category.find(id)
    end

    if @track.categories << @categories
      flash[:notice] = "#{@categories.count} categories have been added."
      redirect_to certification_track_path(@track)
    else
      render "new"
    end
  end
end