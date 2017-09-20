require "web/views/application_view"

class HomeView < ApplicationView
  def tweets
    if signed_in?
      repo.where(Tweet, user_id: current_user[:id])
    else
      []
    end
  end
end
