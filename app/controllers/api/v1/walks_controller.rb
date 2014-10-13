class Api::V1::WalksController < ApplicationController
  include WalkLocator
  include WalkCreator

  before_action :set_walk, only: [:show, :edit, :update, :destroy]


  def index
    if @walks
      render :json => @walks, each_serializer: WalkSerializer, root: "walks"
    else
      @error = Error.new(:text => "404 Not found", :status => 404, :url => request.url, :method => request.method)
      render :json => @error.serializer
    end
  end

  # GET /walks/1
  # GET /walks/1.json
  def show
    if @walk
      render :json => @walk, serializer: WalkSerializer, root: "walk"
    else
      @error = Error.new(:text => "404 Not found", :status => 404, :url => request.url, :method => request.method)
      render :json => @error.serializer
    end
  end

  # GET /walks/1/edit
  def edit

  end

  # GET /walks/new
  def new
    @walk = Walk.new
  end

  # POST /walks
  # POST /walks.json
  def create
    @walk = initialize_walk(walk_params)
    if @walk.save
      render :json => @walk, serializer: WalkSerializer, root: "walk"
    else
      render :json => @walk.errors
    end

  end

  # PATCH/PUT /walks/1
  # PATCH/PUT /walks/1.json
  def update
    if @walk.update(walk_params)
      render :json => @walk, serializer: WalkSerializer, root: "walk"
    else
      render :json => @walk.errors
    end
  end

  # DELETE /walks/1
  # DELETE /walks/1.json
  def destroy
    @walk.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_walk
    @walk = Walk.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def walk_params
    params.require(:walk).permit(:title, :author, :location, :pins, :categories)
  end
end
