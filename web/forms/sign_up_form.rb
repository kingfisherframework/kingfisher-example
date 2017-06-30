class SignUpForm
  def initialize(params)
    @_params = params
  end

  def params
    _params
  end

  private
  attr_reader :_params
end
