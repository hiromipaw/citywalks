class Error
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :text, :status, :url, :method

  def _links
    {:url => request, :entry => entry}
  end

  def request
    href = URI::encode(url)
    {:href => href, :method => method, :rel => "request"}
  end

  def entry
    href = URI::encode("/api/v1/")
    {:href => href, :method => "GET", :rel => "entry point", :params => params}
  end

  def params
    {:point => {:value => "{lon},{lat}", :optional => true}, :title => {:value => "text", :optional => true}}
  end

  def serializer
    {:error => {:url => url, :text => text, :status => status, :method => method,
                :_links => _links }}
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end