  #ragios/main.rb
  require 'rubygems'
  require "bundler/setup"
  
  dir = Pathname(__FILE__).dirname.expand_path
  require dir + 'lib/ragios'

  #Add your code here



















 #trap Ctrl-C to exit gracefully
    puts "PRESS CTRL-C to QUIT"
     loop do
       trap("INT") { puts "\nExiting"; exit; }
     sleep(3)
    end
