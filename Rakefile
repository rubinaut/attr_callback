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

task :build do
  system "gem build attr_callback.gemspec"
end
