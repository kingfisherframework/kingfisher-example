require "config/#{ENV.fetch("KINGFISHER_ENV")}.rb"

module Kingfisher
  class App
    def initialize(router)
      @router = router
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
    attr_reader :builder, :router

    def config
      @_config ||= Config.new
    end

    def repo
      @_repo ||= config.repo.new(config.backend)
    end
  end
end
