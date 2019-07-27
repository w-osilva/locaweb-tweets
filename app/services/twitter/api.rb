module Twitter
  class Api
    def self.singleton
      @@api ||= new $twitter_config
    end

    attr_accessor :url, :username, :header
    attr_reader :response

    def initialize(url: nil, username: nil)
      @url = url
      @username = username
      @header = { 'Username' => username }
    end

    def get
      @response = RestClient.get(url, header)
      JSON.parse(response.body)
    end

  end
end
