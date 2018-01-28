require "web/views/application_view"

class UserView < ApplicationView
  def user
    locals.fetch(:user)
  end
end
