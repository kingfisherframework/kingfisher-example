require "services/authentication"
require "warden"

class BCryptPasswordStrategy < ::Warden::Strategies::Base
  def valid?
    params["id"] && params["password"]
  end

  def authenticate!
    Authentication.new(user, params["password"]).run
  end

  private

  def user
    repo = env["dependencies"].service(:repo)
    repo.find_by(User, id: params["id"])
  end
end

Warden::Strategies.add(:password_strategy, BCryptPasswordStrategy)
Warden::Manager.serialize_into_session { |user| user[:id] }
Warden::Manager.serialize_from_session { |id| env["dependencies"].service(:repo).find(User, id) }
