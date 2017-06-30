module Kingfisher
  class RouteSet
    def initialize
      @routes = []
    end

    def match(request)
      mroute = @routes.find { |route| route.match?(request) }
      Operation.either(->(_){ raise NoRouteError, "#{request.request_method} #{request.path}" }, mroute).result
    end

    def get(url, controller, method)
      @routes << Route.new(:get, url, controller, method)
    end

    def post(url, controller, method)
      @routes << Route.new(:post, url, controller, method)
    end
  end

  class Route
    def initialize(verb, url, app, method)
      @verb = verb
      @url = url
      @app = app
      @method = method
    end

    def match?(request)
      request.request_method.downcase.to_sym == @verb && request.path == @url
    end

    def call(request)
      view = @app.new(request).public_send(@method)
      [view.status_code, view.headers, view.body]
    end
  end

  module Operation
    def self.either(failure, maybe)
      if maybe.nil?
        Failure.new(failure)
      else
        Success.new(maybe)
      end
    end
  end

  class Failure
    attr_reader :failure
    def initialize(failure)
      @failure = failure
    end

    def result
      @failure
    end

    def success?
      false
    end
  end

  class Success
    attr_reader :success
    def initialize(success)
      @success = success
    end

    def result
      @success
    end

    def success?
      true
    end
  end
end
