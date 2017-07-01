module Kingfisher
  NoRouteError = Class.new(StandardError)

  class Router
    def call(env)
      request = Rack::Request.new(env)
      resp = route(request).call(env)
      $stdout.puts resp.inspect
      resp
    end

    private

    def route_set
      @_route_set ||= RouteSet.new
    end

    def route(request)
      route_set.match(request)
    end

    def get(url, controller, action)
      route_set.get(url, controller, action)
    end

    def post(url, controller, action)
      route_set.post(url, controller, action)
    end

    def delete(url, controller, action)
      route_set.delete(url, controller, action)
    end
  end
end
