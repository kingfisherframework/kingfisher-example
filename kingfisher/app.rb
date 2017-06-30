module Kingfisher
  class App
    def initialize(router, config)
      @router = router
      @config = config
      @builder = Rack::Builder.new

      config.middleware.each do |(middleware, args)|
        if args.is_a?(Proc)
          builder.use middleware, &args
        else
          builder.use middleware, *args
        end
      end

      builder.run(router)
    end

    def call(env)
      request = Rack::Request.new(env)
      request.env["repo"] = repo

      builder.call(env)
    end

    private
    attr_reader :builder, :router, :config

    def repo
      @_repo ||= config.repo.new(config.backend)
    end
  end
end
