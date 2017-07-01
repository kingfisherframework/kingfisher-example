module Kingfisher
  class App
    def initialize(router, config)
      @router = router
      @config = config
      @builder = Rack::Builder.new

      config.middlewares.each do |middleware|
        builder.use middleware.klass, *middleware.args, &middleware.block
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
