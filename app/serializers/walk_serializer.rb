class WalkSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :location, :pins, :categories, :created_at, :points

  def id
    object.id.to_s
  end

  def points
    pins = Array.new
    object.pins.each do |pin|
      point = object.class.get_pin(pin)
      if point.doc["pin"]
        pins.append(point.doc["pin"])
      end
    end
    pins
  end


end
