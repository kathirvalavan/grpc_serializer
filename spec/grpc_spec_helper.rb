module GrpcSpecHelper

  def default_all_datatype_hash
    {
      'double_type': 2.123456789123456789123,
      'float_type': 2.5,
      'int32_type': 2147483640,
      'int64_type': 3147483640,
      'uint32_type': 2147483640,
      'uint64_type': 3147483640,
      'sint32_type': -2147483640,
      'sint64_type': -3147483640,
      'fixed32_type': 2147483640,
      'fixed64_type': 3147483640,
      'sfixed32_type': -2147483640,
      'sfixed64_type': -3147483640,
      'bool_type': true,
      'string_type': "hello ruby",
    }
  end
end
