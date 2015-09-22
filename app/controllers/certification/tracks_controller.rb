class Certification::TracksController < ApplicationController
  before_filter :authorized?

  def index
    @tracks = Certification::Track.all
  end

  def new
    @track = Certification::Track.new
  end

  def show
    @track = Certification::Track.find(params[:id])
    @categories = @track.categories
  end

  def edit
    @track = Certification::Track.find(params[:id])
  end

  def update
    @track = Certification::Track.find(params[:id])

    if @track.update_attributes(track_params)
      flash[:notice] = 'Certification Track was successfully updated.'
      redirect_to certification_track_path(@track)
    else
      render "edit"
    end
  end

  def create
    @track = Certification::Track.new(track_params)

    if @track.save
      flash[:notice] = 'Certification Track was successfully created.'
      redirect_to certification_track_path(@track)
    else
      render "new"
    end
  end

  private

  def track_params
    params.require(:certification_track).permit(:enabled, :name)
  end
end