use Rack::Static, root: "web/public"
use Rack::Session::Cookie, secret: ENV.fetch("SECRET_KEY_BASE")
use Rack::MethodOverride

class BcryptPasswordStrategy < ::Warden::Strategies::Base
  def valid?
    params["id"] && params["password"]
  end

  def authenticate!
    Authentication.new(user, params["password"]).run
  end

  private

  def user
    env["repo"].find_by(User, id: params["id"])
  end
end

use Warden::Manager do |manager|
  manager.failure_app = ->(env) { [400, { "Content-Type" => "plain/text" }, ["Auth Failure"]] }
end

Warden::Strategies.add(:password_strategy, BcryptPasswordStrategy)
