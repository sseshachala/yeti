class Rmonitor 

include ActiveModel::Validations
include ActiveModel::Serialization
extend ActiveModel::Naming 
include ActiveModel::Conversion
include RmonitorsHelper

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

url_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

validates :every, :presence => true, :numericality => {:only_integer => true}

validates :test, :presence => true,
                 :length => {:within => 4..50}

#validates :contact, :presence => true,
#                    :format => {:with => email_regex}

validates :url, :presence => true,
                :format => {:with => url_regex}

attr_accessor :attributes,:every, :test,:contact, :url #, :notify_interval

 def initialize(attributes = {})
    @attributes = attributes
    @every = @attributes["every"]
    @test = @attributes["test"]
    @contact = @attributes["contact"]
    @url = @attributes["url"]
  end

 def read_attribute_for_validation(key)
   @attributes[key]
 end


def update_attributes(params)
 @attributes = params["rmonitor"]
  
 if self.valid?
   return update_monitor(params)
 else
  false
 end
end

def update_monitor(params)
 str = Yajl::Encoder.encode(make_monitor(params))
  response = RestClient.put 'http://127.0.0.1:5041/monitors/' + params["id"],str, {:content_type => :json, :accept => :json}
  return true unless response.code != 200 
end

def create_monitor(owner, params)
   
   m = make_monitor(params)
   data = [{:monitor => 'metered_url_monitor',
              :tag => owner.username,
             :every => m["every"], 
              :test => @attributes["test"], 
                :contact =>  owner.attributes["email"],
                   :url => @attributes["url"],
                         :via => 'ses'}]
  
       str = Yajl::Encoder.encode(data)
     response = RestClient.post 'http://127.0.0.1:5041/monitors', str, {:content_type => :json, :accept => :json}
     return true unless response.code != 200 
end

 def save(owner, params)
   if self.valid?
     return create_monitor(owner, params)
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

def self.find_by_owner(id)
 begin
  response = RestClient.get 'http://127.0.0.1:5041/monitors/tag/' + id + '/'
  @rmonitors = Yajl::Parser.parse(response.to_str)
 rescue RestClient::ResourceNotFound => e
  @rmonitors = []
 end
end

def pause
  response = RestClient.put 'http://127.0.0.1:5041/monitors/' + @attributes["_id"] + '/state/stopped',{:content_type => :json}
end

def restart
 response = RestClient.put 'http://127.0.0.1:5041/monitors/' + @attributes["_id"] + '/state/active',{:content_type => :json}
end

def destroy
   response = RestClient.delete 'http://127.0.0.1:5041/monitors/' + @attributes["_id"]
end

 def persisted?
  false
 end

end
