require "rake"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_filterable"
    gem.summary = %Q{Filter attributes and stuff.}
    gem.email = "rob.ares@gmail.com"
    gem.homepage = "http://github.com/rares/acts_as_filterable"
    gem.authors = ["Rob Ares"]

    gem.add_dependency("activerecord", ">= 1.15.0") 
    gem.add_runtime_dependency("activesupport", ">= 1.4.4")
    gem.add_development_dependency("Shoulda", ">= 0")
    gem.add_development_dependency("matchy", ">= 0")   
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require "rake/testtask"
Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/*_test.rb"
  test.verbose = false
  test.options =  "-v"
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

begin   
  require "yard"
  YARD::Rake::YardocTask.new do |t|
    t.files   = ["lib/**/*.rb"]
    t.options = ["--private", "--protected"]
  end
rescue LoadError
  STDOUT.puts "Couldn't load yardoc"
end
