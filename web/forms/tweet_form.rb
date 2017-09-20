require "web/forms/application_form"

class TweetForm < ApplicationForm
  def initialize(request)
    @request = request
  end

  def params
    {
      body: request.params["tweet"]["body"],
      user_id: current_user[:id]
    }
  end

  private
  attr_reader :request

  def current_user
    @_current_user ||= User.new(request.env["warden"].user)
  end
end
