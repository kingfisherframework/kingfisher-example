require "web/views/application_view"
require "web/views/tweet_view"

class UserView < ApplicationView
  def user
    locals.fetch(:user)
  end

  def tweets
    repo.assoc(user, Tweet)
  end
end
