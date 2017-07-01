require "sequel"

module Kingfisher
  module DatabaseBackends
    class PostgreSQL
      def initialize
        @db = open_db
      end

      def all(model)
      end

      def create(model, params)
        raise "Implement me"
      end

      def find(model, id)
      end

      def find_by(model, attributes)
      end

      private
      attr_reader :db

      def open_db
        Sequel.connect ENV.fetch("DATABASE_URL")
      end

      def table_name(model)
        model.name.downcase.to_sym
      end

      def symbolize_keys(hash)
        hash.each_with_object({}) do |(key, value), new_hash|
          new_hash[key.to_sym] = value
        end
      end
    end
  end
end
