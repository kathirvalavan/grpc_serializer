Gem::Specification.new do |s|
  s.name        = 'grpc_serializer'
  s.version     = '1.0'
  s.date        = '2021-07-20'
  s.summary     = "Ruby Grpc serilizer"
  s.description = "A simple gem for nested grpc message encoding and decoding"
  s.authors     = ["kathir"]
  s.email       = 'kathirvalavan.ict@gmail.com'
  s.files       = ["lib/grpc_serializer.rb"]
  s.homepage    =
      'https://rubygems.org/gems/grpc_serializer'
  s.license       = 'MIT'
  s.metadata    = { "source_code_uri" => "https://github.com/kathirvalavan/grpc_serializer" }
  s.required_ruby_version = ">= 2.3"

  s.add_development_dependency "bundler", "~> 1.17"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency 'grpc-tools', '~> 1.17.1'
  s.add_dependency 'grpc', '~> 1.18.0'
  s.add_dependency 'google-protobuf', '~> 3.6.1'

end
