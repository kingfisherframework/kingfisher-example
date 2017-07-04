require "rack"
require_relative "../../../kingfisher/middlewares/csrf"
require_relative "../../../kingfisher/controller"

RSpec.describe Kingfisher::Middlewares::CSRF do
  def stub_csrf
    csrf = double("Kingfisher::CSRF")
    request = double("Rack::Request")
    allow(Rack::Request).to receive(:new) { request }
    allow(Kingfisher::CSRF).to receive(:new).with(request) { csrf }
    csrf
  end

  def app
    double("Rack::Builder")
  end

  class ForbiddenController < Kingfisher::Controller
    def show; end
  end

  describe "invalid token" do
    it "reset and invokes given controller and action" do
      csrf = stub_csrf
      allow(csrf).to receive(:reset!)
      allow(csrf).to receive(:safe?) { false }

      middleware = described_class.new(
        app,
        controller: ForbiddenController,
        action: :show
      )

      middleware.call({})

      expect(csrf).to have_received(:reset!)
    end
  end
end
