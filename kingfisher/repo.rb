module Kingfisher
  class Repo
    def initialize(backend)
      @backend = backend
    end

    def all(model)
      backend.all(model)
    end

    def find(model, id)
      backend.find(model, id)
    end

    def create(model, params)
      backend.create(model, params)
    end

    private
    attr_reader :backend

  end
end
