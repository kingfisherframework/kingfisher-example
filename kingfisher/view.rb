require "slim"

module Kingfisher
  class View
    def status_code
      @_status_code ||= 200
    end

    def headers
      @_headers ||= { "Content-Type" => "text/html" }
    end

    def body
      [render]
    end

    def render
      Slim::Template.
        new("web/templates/#{template}.slim").
        render(self)
    end

    private
    attr_reader :template
  end
end
