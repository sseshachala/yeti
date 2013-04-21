###############################################################################
 #  Copyright 2008-2010 Amazon Technologies, Inc
 #  Licensed under the Apache License, Version 2.0 (the "License");
 #
 #  You may not use this file except in compliance with the License.
 #  You may obtain a copy of the License at: http://aws.amazon.com/apache2.0
 #  This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 #  CONDITIONS OF ANY KIND, either express or implied. See the License for the
 #  specific language governing permissions and limitations under the License.
 ##############################################################################

#require 'uri'
require 'signatureutils.rb'

module Amazon
module FPS

class Fpscbui

  #Set these values depending on the service endpoint you are going to hit
  @@app_name = "CBUI"
  @@http_method = "GET"
  @@cbui_version = "2009-01-09"

   def self.get_cbui_params(global_amount_limit, pipeline, caller_reference, return_url, signature_version, signature_method)
    params = {}
    params["callerKey"] = @@access_key
    params["globalAmountLimit"] = global_amount_limit
    params["pipelineName"] = pipeline
    params["returnUrl"] = return_url
    params["version"] = @@cbui_version
    params["callerReference"] = caller_reference unless caller_reference.nil?
    
    if (signature_version.nil?) then
        params[Amazon::FPS::SignatureUtils::SIGNATURE_VERSION_KEYNAME] = "1"
    else
        params[Amazon::FPS::SignatureUtils::SIGNATURE_VERSION_KEYNAME] = signature_version
    end
    params[Amazon::FPS::SignatureUtils::SIGNATURE_METHOD_KEYNAME] = signature_method unless signature_method.nil?
    
    return params
  end

  def self.get_cbui_url(params)
    cbui_url = @@service_end_point + "?"

    isFirst = true
    params.each { |k,v|
      if(isFirst) then
        isFirst = false
      else
        cbui_url << '&'
      end

      cbui_url << Amazon::FPS::SignatureUtils.urlencode(k)
      unless(v.nil?) then
        cbui_url << '='
        cbui_url << Amazon::FPS::SignatureUtils.urlencode(v)
      end
    }
    return cbui_url
  end

  def self.url(caller_reference)
    fps_return_url = "http://" + @@fps_return_domain + "/authorized"
    uri = URI.parse(@@service_end_point)
    params = get_cbui_params("100", "MultiUse", caller_reference,  
                    fps_return_url, "2", Amazon::FPS::SignatureUtils::HMAC_SHA256_ALGORITHM);

    signature = Amazon::FPS::SignatureUtils.sign_parameters({:parameters => params, 
                                            :aws_secret_key => @@secret_key,
                                            :host => uri.host,
                                            :verb => @@http_method,
                                            :uri  => uri.path })
    params[Amazon::FPS::SignatureUtils::SIGNATURE_KEYNAME] = signature
    return get_cbui_url(params)
  end
end

end
end

#Amazon::FPS::FPSCBUI.url(user_id)

