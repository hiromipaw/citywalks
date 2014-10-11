class Walk
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Wikipin


  field :title, type: String
  field :author, type: String

  field :pins, type: Array

  field :location, :type => Array

  field :categories, :type => Array

  index({ location: "2d" }, { min: -200, max: 200 })

  validates :pins, length: { minimum: 0, maximum: 10 }

end
