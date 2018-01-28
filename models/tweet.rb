require "kingfisher/model"

class Tweet < Kingfisher::Model
  def body
    attributes["body"]
  end
end
