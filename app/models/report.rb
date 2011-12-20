class Report 
 
include ActiveModel::Validations
include ActiveModel::Serialization
extend ActiveModel::Naming 
include ActiveModel::Conversion

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :every, :presence => true

validates :contact, :presence => true,
                    :format => {:with => email_regex}

attr_accessor :attributes,:every, :contact


  def initialize(attributes = {})
    @attributes = attributes
    @every = @attributes["every"]
    @contact = @attributes["contact"]
  end

 def read_attribute_for_validation(key)
   @attributes[key]
 end 

def update_attributes(params)
 @attributes = params["report"]
 if self.valid?
   str = Yajl::Encoder.encode(params["report"])
   response = RestClient.put 'http://127.0.0.1:5041/status_updates/' + params["id"],str, {:content_type => :json, :accept => :json}
   return true unless response.code != 200 
 else
  false
 end
end

def self.find_object(id)
  hash = find(id)
  @report = Report.new(hash)
end

 def self.find(id)
  begin
   response = RestClient.get 'http://127.0.0.1:5041/status_updates/' + id
   @reports = Yajl::Parser.parse(response.to_str)
  rescue => e
   raise
  end
 end

 def self.all
  begin
   response = RestClient.get 'http://127.0.0.1:5041/status_updates'
   @reports = Yajl::Parser.parse(response.to_str)
  rescue RestClient::ResourceNotFound => e
  []
 end
 end

def restart(tag)
 response = RestClient.put 'http://127.0.0.1:5041/status_updates/' + tag + '/state/active',{:content_type => :json}
end

def stop(tag)
 response = RestClient.put 'http://127.0.0.1:5041/status_updates/' + tag + '/state/stopped',{:content_type => :json}
end 

def save(tag)
  if self.valid?
     if(Report.find_by_owner(tag) == {})
        config = {   :every =>  @attributes["every"],
                   :contact =>  @attributes["contact"],
                   :via => 'gmail',
                  :tag => tag,                  
                  }
       str = Yajl::Encoder.encode(config)
       response = RestClient.post "http://127.0.0.1:5041/status_updates/", str, {:content_type => :json, :accept => :json}
       return true unless response.code != 200 
     else 
        false 
     end
  else
    false
  end 
end

def destroy(tag)
  response = RestClient.delete 'http://127.0.0.1:5041/status_updates/' + tag
end


def self.find_by_owner(tag)
  begin
  response = RestClient.get 'http://127.0.0.1:5041/status_updates/tag/' + tag
  reports = Yajl::Parser.parse(response.to_str)
  report = reports[0]
 rescue RestClient::ResourceNotFound => e
  {}
 end
end

 def persisted?
  false
 end

end
