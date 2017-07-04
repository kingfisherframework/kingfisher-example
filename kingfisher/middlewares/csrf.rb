require_relative "../csrf"

module Kingfisher
  module Middlewares
    class CSRF
      def initialize(app, args)
        @app = app
        @controller = args[:controller]
        @action = args[:action]
      end

      def call(env)
        request = Rack::Request.new(env)
        csrf = Kingfisher::CSRF.new(request)

        if csrf.safe?
          app.call(env)
        else
          csrf.reset!
          controller.new(request).public_send(action)
        end
      end

      private
      attr_reader :app, :controller, :action
    end
  end
end
