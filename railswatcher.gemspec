
# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "railswatcher/version"

Gem::Specification.new do |s|
  s.name        = "railswatcher"
  s.version     = Railswatcher::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ["Jonathan Siu"]
  s.email       = ["jonpsiu@gmail.com"]
  s.homepage    = "https://github.com/jonsiu/railswatcher"
  s.summary     = 'Logs all database queries and sends them to a specified endpoint for performance analysis and debugging.'
  s.description = 'Logs all database queries and sends them to a specified endpoint for performance analysis and debugging.'

  s.required_ruby_version     = '>= 2.6.0'

  s.add_dependency "activesupport", "~> 6.1"
  s.add_dependency "httparty", "~> 0.17.3"
end