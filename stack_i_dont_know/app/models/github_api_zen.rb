require 'Dotenv'
load 'Dotenv'

class Github_Api_Zen
  include HTTParty

  def self.response
    api_key = ENV["Key"]
    api_password = ENV["Password"]

  end
end
