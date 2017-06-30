module Kingfisher
  class NullRepo
    def all(_)
      []
    end
  end

  class Controller
    def initialize(request)
      @request = request
    end

    private
    attr_reader :request

    def repo
      request.env.fetch("repo") { NullRepo.new }
    end
  end
end
