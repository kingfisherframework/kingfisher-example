module Kingfisher
  class View
    def status_code
      @status_code ||= 200
    end

    def headers
      @headers ||= { "Content-Type" => "text/html" }
    end

    def body
      [render]
    end

    def render
      "Hello WOrld"
    end
  end
end
