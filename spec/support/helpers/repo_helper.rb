module RepoHelper
  def repo
    Kingfisher::Repo.new(Config.new.backend)
  end
end
