class Rmonitor 

include ActiveModel::Validations
include ActiveModel::Serialization
extend ActiveModel::Naming 
include ActiveModel::Conversion

attr_accessor :attributes,:every, :test,:contact, :url, :notify_interval

 def initialize(attributes = {})
    @attributes = attributes
    @every = @attributes["every"]
    @test = @attributes["test"]
    @contact = @attributes["contact"]
    @url = @attributes["url"]
    @notify_interval = @attributes["notify_interval"]
  end

 def read_attribute_for_validation(key)
   @attributes[key]
 end

def update_attributes(params)
 if self.valid?
  str = Yajl::Encoder.encode(params["rmonitor"])
  response = RestClient.put 'http://127.0.0.1:5041/monitors/' + params["id"],str, {:content_type => :json, :accept => :json}
  return true unless response.code != 200 
 else
  false
 end
end

 def save(owner)
   if self.valid?
     data = [{:monitor => 'url',
              :tag => owner.username,
             :every => @attributes["every"], 
              :test => @attributes["test"], 
                :contact => @attributes["contact"],
                   :url => @attributes["url"],
                        :notify_interval => @attributes["notify_interval"]}]
  
       str = Yajl::Encoder.encode(data)
     response = RestClient.post 'http://127.0.0.1:5041/monitors', str, {:content_type => :json, :accept => :json}
     return true unless response.code != 200 
   else
    false
   end
 end

 def self.all
   response = RestClient.get 'http://127.0.0.1:5041/monitors'
   @monitors = Yajl::Parser.parse(response.to_str)
 end

def self.find_object(id)
   monitor_hash = find(id)
   @rmonitor = Rmonitor.new(monitor_hash)
end


 def self.find(id)
   response = RestClient.get 'http://127.0.0.1:5041/monitors/' + id
   @rmonitors = Yajl::Parser.parse(response.to_str)
 end

def destroy
   response = RestClient.delete 'http://127.0.0.1:5041/monitors/' + @attributes["_id"]
end

 def persisted?
  false
 end

end
