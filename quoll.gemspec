$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quoll/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quoll"
  s.version     = Quoll::VERSION
  s.authors     = ["Kurt Schwarze","Michael Krüger"]
  s.email       = ["schwarze@gmail.com"]
  s.homepage    = "http://www.macwombat.de/quoll"
  s.summary     = "Simple reporting engine for activeadmin"
  s.description = "Simple reporting engine for activeadmin"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
