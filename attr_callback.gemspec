# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift "lib"
require 'attr_callback/version'

Gem::Specification.new do |s|
  s.name = "attr_callback"
  s.version = AttrCallback::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Dwayne Litzenberger"]
  s.email = ["dlitz@infonium.ca"]
  s.homepage = "http://github.com/rubinaut/attr_callback"
  s.summary = "Convenience method for providing user-definable callbacks."
  s.description = <<EOF
The attr_callback gem lets you create user-definable callback method attributes
conveniently.
EOF

  s.required_rubygems_version = ">= 1.3.6"

  s.files = Dir.glob("{lib,test}/**/*") + %w( MIT-LICENSE README.rdoc Rakefile )
  s.extra_rdoc_files = %w( README.rdoc )
  s.require_paths = ["lib"]
end

