module Kingfisher
  NoRouteError = Class.new(StandardError)

  class Router
    def route(request)
      @route_set.match(request)
    end

    private
    attr_reader :route_set

    def route_set
      @route_set ||= RouteSet.new
    end

    def get(url, controller, action)
      route_set.get(url, controller, action)
    end

    def post(url, controller, action)
      route_set.post(url, controller, action)
    end
  end
end
