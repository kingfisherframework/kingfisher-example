require "web/controllers/application_controller"
require "web/views/sign_up_view"
require "web/forms/sign_up_form"
require "services/sign_up"
require "services/sign_in"

class UsersController < ApplicationController
  def new
    view SignUpView
  end

  def create
    user = sign_up
    sign_in(user)
    redirect to: "/"
  end

  private
  def sign_up
    form = SignUpForm.new(request)
    SignUp.new(repo, form.params).run
  end

  def sign_in(user)
    SignIn.new(warden, user).run
  end

  def warden
    request.env["warden"]
  end
end
