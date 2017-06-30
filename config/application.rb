module Twitter
  class Application
    def self.start
      system("puma app.ru")
    end
  end
end
