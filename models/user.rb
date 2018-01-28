require "kingfisher/model"

class User < Kingfisher::Model
  def email
    self["email"]
  end
end
