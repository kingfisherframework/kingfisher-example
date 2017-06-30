class Repo
  def initialize(backend)
    @backend = backend
  end

  def all(model, options = {})
    table_name = options.fetch(:table_name) { model.name.downcase }
    @backend.all(table_name)
  end
end
