require "web/views/sign_up_view"
require "web/forms/sign_up_form"
require "services/sign_up"
require "services/sign_in"

class UsersController < Kingfisher::Controller
  def new
    SignUpView.new
  end

  def create
    form = SignUpForm.new(params)
    user = SignUp.new(form.params, request).run
    SignIn.new(user, request).run
    redirect to: "/"
  end
end
