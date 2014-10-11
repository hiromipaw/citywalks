class WalkController < ApplicationController

  def index
    if @walks
      render :json => @walks, each_serializer: WalkSerializer, root: "walks"
    else
      @error = Error.new(:text => "404 Not found", :status => 404, :url => request.url, :method => request.method)
      render :json => @error.serializer
    end
  end

  def show

  end

  def create

  end

  def delete

  end
end
