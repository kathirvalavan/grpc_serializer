require 'spec_helper'

include GrpcSpecHelper


describe GrpcSerializer do

  it 'should encode and decode back with all datatypes in level 0' do
    msg = default_all_datatype_hash.dup
    msg_obj = GrpcSerializer.hash_to_grpc_object(msg, AllDataTypes)
    transformed_msg = GrpcSerializer.grpc_object_to_hash(msg_obj, AllDataTypes)
    expect(msg).to eq transformed_msg
  end

  it 'should encode and decode back with all datatypes in level 1' do
    msg = default_all_datatype_hash.dup
    msg[:all_data_types] = default_all_datatype_hash.dup
    msg_obj = GrpcSerializer.hash_to_grpc_object(msg, AllDataTypesSelfNested)
    transformed_msg = GrpcSerializer.grpc_object_to_hash(msg_obj, AllDataTypesSelfNested)
    expect(msg).to eq transformed_msg
  end

  it 'should encode and decode back with all datatypes for repeated fields' do
    msg = default_all_datatype_hash.dup
    repeat_msg = {}
    msg.each do |k, v|
    rp_val = []
      5.times do
        rp_val << v
      end
      repeat_msg[k] = rp_val
    end
    msg_obj = GrpcSerializer.hash_to_grpc_object(repeat_msg, AllDataTypesRepeated)
    transformed_msg = GrpcSerializer.grpc_object_to_hash(msg_obj, AllDataTypesRepeated)
    expect(repeat_msg).to eq transformed_msg
  end

end
