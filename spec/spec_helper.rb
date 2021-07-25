require 'bundler/setup'
Bundler.setup

require_relative '../lib/grpc_serializer'
require_relative './lib/sample_protos_pb.rb'
require 'grpc_spec_helper'

RSpec.configure do |config|
  # some (optional) config here
end
