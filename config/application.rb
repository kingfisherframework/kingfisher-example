require "rack"

module Twitter
  class Application
    def self.start
      Rack::Server.new.start
    end
  end
end
