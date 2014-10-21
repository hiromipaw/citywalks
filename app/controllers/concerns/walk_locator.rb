module WalkLocator
  extend ActiveSupport::Concern

  included do
    before_filter :entry_action, only: [:index]
  end

  def walks_by_point(point)
    point = point.split(",")
    @walks = Walk.geo_near([ point[0].to_f, point[1].to_f ]).spherical
  end

  def walks_by_ip(ip)
    if ip = "127.0.0.1"
      walks_by_point("41.23,2.09")
    else
      block = Walk.request_block(ip).doc["ip_block"]
      if block
        longitude = block["point"].scan(/\(([^\)]+)\)/).last.first.split(" ")[0]
        latitude = block["point"].scan(/\(([^\)]+)\)/).last.first.split(" ")[1]
        Walk.geo_near([ longitude.to_f, latitude.to_f ]).spherical
      end
    end
  end

  def get_block

  end

  def entry_action

    if params[:location]
      @walks = walks_by_point(params[:location])
    else
      @walks = walks_by_ip(request.remote_ip)
    end

  end

end