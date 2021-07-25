# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: sample_protos.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "AllDataTypes" do
    optional :double_type, :double, 1
    optional :float_type, :float, 2
    optional :int32_type, :int32, 3
    optional :int64_type, :int64, 4
    optional :uint32_type, :uint32, 5
    optional :uint64_type, :uint64, 6
    optional :sint32_type, :sint32, 7
    optional :sint64_type, :sint64, 8
    optional :fixed32_type, :fixed32, 9
    optional :fixed64_type, :fixed64, 10
    optional :sfixed32_type, :sfixed32, 11
    optional :sfixed64_type, :sfixed64, 12
    optional :bool_type, :bool, 13
    optional :string_type, :string, 14
  end
  add_message "AllDataTypesSelfNested" do
    optional :double_type, :double, 1
    optional :float_type, :float, 2
    optional :int32_type, :int32, 3
    optional :int64_type, :int64, 4
    optional :uint32_type, :uint32, 5
    optional :uint64_type, :uint64, 6
    optional :sint32_type, :sint32, 7
    optional :sint64_type, :sint64, 8
    optional :fixed32_type, :fixed32, 9
    optional :fixed64_type, :fixed64, 10
    optional :sfixed32_type, :sfixed32, 11
    optional :sfixed64_type, :sfixed64, 12
    optional :bool_type, :bool, 13
    optional :string_type, :string, 14
    optional :all_data_types, :message, 15, "AllDataTypes"
  end
  add_message "AllDataTypesRepeated" do
    repeated :double_type, :double, 1
    repeated :float_type, :float, 2
    repeated :int32_type, :int32, 3
    repeated :int64_type, :int64, 4
    repeated :uint32_type, :uint32, 5
    repeated :uint64_type, :uint64, 6
    repeated :sint32_type, :sint32, 7
    repeated :sint64_type, :sint64, 8
    repeated :fixed32_type, :fixed32, 9
    repeated :fixed64_type, :fixed64, 10
    repeated :sfixed32_type, :sfixed32, 11
    repeated :sfixed64_type, :sfixed64, 12
    repeated :bool_type, :bool, 13
    repeated :string_type, :string, 14
  end
end

AllDataTypes = Google::Protobuf::DescriptorPool.generated_pool.lookup("AllDataTypes").msgclass
AllDataTypesSelfNested = Google::Protobuf::DescriptorPool.generated_pool.lookup("AllDataTypesSelfNested").msgclass
AllDataTypesRepeated = Google::Protobuf::DescriptorPool.generated_pool.lookup("AllDataTypesRepeated").msgclass