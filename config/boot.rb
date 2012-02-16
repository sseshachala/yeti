require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'uri'
require 'base64'
require 'cgi'
require 'openssl'


#setup couchDB configurations
@@username = "obi"
@@password = "trusted"

@@service_end_point = "https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start"
@@access_key = "add access key here"
@@secret_key = "add secret key here"

