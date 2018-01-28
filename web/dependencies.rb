require "kingfisher/repo"
require "kingfisher/repo_backends/postgresql"
require "kingfisher/repo_backends/sqlite3"

class DependencyPayload
  def service(name)
    SERVICES[name]
  end

  private

  SERVICES = {
    repo: Kingfisher::Repo.new(Kingfisher::RepoBackends::PostgreSQL.new(database_url: "postgres://localhost/kingfisher_development"))
  }
  private_constant :SERVICES
end
