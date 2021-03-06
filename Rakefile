require "rake"
require "yaml"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_filterable"
    gem.summary = %Q{Filter attributes and stuff.}
    gem.email = "rob.ares@gmail.com"
    gem.homepage = "http://github.com/rares/acts_as_filterable"
    gem.authors = ["Rob Ares"]

    gem.add_development_dependency("minitest", ">= 1.5.0")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require "rake/testtask"
Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/*_test.rb"
end

begin
  require "rcov/rcovtask"
  Rcov::RcovTask.new do |test|
    test.libs << "test"
    test.pattern = "test/**/*_test.rb"
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require "rake/rdoctask"
Rake::RDocTask.new do |rdoc|
  if File.exist?("VERSION.yml")
    config = YAML.load(File.read("VERSION.yml"))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "acts_as_filterable #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end