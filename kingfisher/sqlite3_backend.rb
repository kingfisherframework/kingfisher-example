require "sequel"

module Kingfisher
  class SqlLite3Backend
    def initialize(file)
      @db = Sequel.connect("sqlite://#{file}")
    end

    def all(table_name)
      db[table_name.to_sym].to_a
    end

    private
    attr_reader :db
  end
end
