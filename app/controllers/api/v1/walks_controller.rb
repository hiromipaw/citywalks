class Api::V1::WalksController < ApplicationController
  include WalkLocator
  include WalkCreator

  def index
    if @walks
      render :json => @walks, each_serializer: WalkSerializer, root: "walks"
    else
      @error = Error.new(:text => "404 Not found", :status => 404, :url => request.url, :method => request.method)
      render :json => @error.serializer
    end
  end

  def show
    @pin = Pin.find(params[:id])
    if @pin
      render :json => @pin, serializer: PinSerializer, root: "pin"
    else
      @error = Error.new(:text => "404 Not found", :status => 404, :url => request.url, :method => request.method)
      render :json => @error.serializer
    end
  end

  def create


  end

  def delete

  end
end
