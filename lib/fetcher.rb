require 'rubygems'
require 'httparty'

module Fetcher
  
  class NotFound < StandardError; end
  
  class User
    include HTTParty
    base_uri 'http://github.com/api/v2/json/user/show/'

    class << self
      def fetch(github_username)
        response = get("/#{github_username}")
        raise(NotFound, "No Github user was found named \"#{github_username}\"") if response.code == 404
        
        Contributor.create(
          :login =>     response['user']['login'],
          :name =>      response['user']['name'],
          :company =>   response['user']['company'],
          :location =>  response['user']['location'],
          :website =>   response['user']['blog'],
          :email =>     response['user']['email']
        )
      end
    end
  end
end