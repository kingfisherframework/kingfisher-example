class UsersController < Kingfisher::Controller
  def new
    SignUpView.new
  end

  def create
    form = SignUpForm.new(params)
    user = SignUp.new(form.params, request).run
    SignIn.new(user, request).run
    redirect_to "/"
  end
end
