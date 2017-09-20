require "web/controllers/application_controller"
require "web/forms/tweet_form"
require "services/create_tweet"

class TweetsController < ApplicationController
  def create
    create_tweet
    redirect to: "/"
  end

  private

  def create_tweet
    CreateTweet.new(repo, tweet_params).run
  end

  def tweet_params
    tweet_form.params
  end

  def tweet_form
    @_tweet_form ||= TweetForm.new(request)
  end
end
