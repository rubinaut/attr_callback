begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "attr_callback"
    gemspec.summary = "Convenience method for providing user-definable callbacks."
    gemspec.description = <<EOF
The attr_callback gem lets you create user-definable callback method attributes
conveniently.
EOF
    gemspec.email = "dlitz@infonium.ca"
    gemspec.homepage = "http://github.com/rubinaut/attr_callback"
    gemspec.authors = ["Dwayne Litzenberger"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |t|
  t.rdoc_files = Dir.glob(%w( README* MIT-LICENSE lib/**/*.rb *.rdoc )).uniq
  t.main = "README.rdoc"
  t.title = "attr_callback - RDoc Documentation"
  t.options = %w( --charset -UTF-8 --line-numbers )
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
end
