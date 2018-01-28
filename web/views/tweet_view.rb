require "web/views/application_view"

class TweetView < ApplicationView
  def body
    tweet["body"]
  end

  private

  def tweet
    locals.fetch(:tweet)
  end
end
