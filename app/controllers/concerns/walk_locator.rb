module WalkLocator
  extend ActiveSupport::Concern

  included do
    before_filter :entry_action
  end


  def walks_by_point(point)
    point = point.split(',')
    @walks = Walk.geo_near([ point[0].to_f, point[1].to_f ]).spherical
  end

  def walks_by_ip(ip)
    block =
    if block
      Walks.geo_near([ block.longitude.to_f, block.latitude.to_f ]).spherical
    end
  end

  def get_block

  end

  def entry_action

    if params[:point]
      @walks = walks_by_point(params[:point])
    else
      @walks = walks_by_ip(request.remote_ip)
    end

  end

end