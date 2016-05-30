$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_bloomfilter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_bloomfilter"
  s.version     = ActsAsBloomfilter::VERSION
  s.authors     = ["Matt Lankford"]
  s.email       = ["matt.lankford@gmail.com"]
  s.homepage    = "https://github.com/lankford/acts_as_bloomfilter"
  s.summary     = "Use an active record model:field(s) as a bloomfilter"
  s.description = "Project started mainly for Extract Transform Load (ETL) operations"
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"

  s.add_development_dependency "sqlite3"
end
