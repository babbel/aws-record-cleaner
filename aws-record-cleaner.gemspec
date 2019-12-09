lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "aws-record-cleaner/version"

Gem::Specification.new do |spec|
  spec.name          = "aws-record-cleaner"
  spec.version       = AwsRecordCleaner::VERSION
  spec.authors       = ["Aliaksei Kliuchnikau"]
  spec.email         = ["akliuchnikau@babbel.com"]

  spec.summary       = "Database cleaner compatible with aws-record gem."
  spec.description   = "Database cleaner compatible with aws-record gem."
  spec.homepage      = "https://github.com/babbel/aws-record-cleaner"
  spec.license       = "Apache-2.0"

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "aws-record"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec", "~> 3.0"
end
