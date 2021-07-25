class GrpcSerializer

  CUSTOM_ENCODED_TYPES = {}.freeze
  REPEATED_ENCODED_TYPES = {}.freeze

  def self.hash_to_grpc_object(source_hash, message_class)
    final_hash = source_hash.dup
    serialize_with_descriptor(message_class.descriptor, final_hash )
  end

  def self.grpc_object_to_hash(source_hash, message_class)
    final_hash = source_hash.dup
    value, _ = deserialize_with_descriptor(message_class.descriptor, final_hash)
    value
  end

  private

  def self.serialize_with_descriptor(descriptor_class, hash_value, render_as_hash: false)
    new_hash = {}
    return hash_value if descriptor_class.nil?
    available_keys = hash_value.keys
    descriptor_class.entries.each do |entry|
      is_key_present = available_keys.include?(entry.name.to_sym)
      value =  serialize_with_field_descriptor(entry, hash_value[entry.name.to_sym], is_key_present: is_key_present)
      unless value.nil?
        new_hash[entry.name] = value
      end
    end

    render_as_hash ? new_hash : descriptor_class.msgclass.new(new_hash)
  end

  def self.serialize_with_field_descriptor(field_descriptor, value, is_key_present: true)
    return value if field_descriptor.nil?

    if field_descriptor.label == :repeated
      return serialize_with_repeated_field(field_descriptor, value)
    end
    if field_descriptor.type == :message
      custom_encode = CUSTOM_ENCODED_TYPES[field_descriptor.subtype.msgclass]
      if custom_encode
        return field_descriptor.subtype.msgclass.encode_value(value, is_key_present)
      end
      if field_descriptor.subtype.is_a?(Google::Protobuf::Descriptor)
        return serialize_with_descriptor(field_descriptor.subtype, value) unless value.nil?
      end

      return field_descriptor.subtype.msgclass.new(value) unless value.nil?

    end
    value
  end

  def self.serialize_with_repeated_field(field_descriptor, value)
   if field_descriptor.label == :repeated
     if field_descriptor.subtype && field_descriptor.subtype.lookup("key")
       if field_descriptor.subtype.lookup("value")
         value_dup = ({})
         org_value = value || {}
         org_value.keys.each do |k|
           value_dup[k.to_s] = (serialize_with_field_descriptor(field_descriptor.subtype.lookup("value"), org_value[k]))
         end
         return value_dup
       else
         return value
       end
     end
     return (value || []).map  { |v| serialize_with_descriptor(field_descriptor.subtype, v) }
   end
 end

 def self.deserialize_with_descriptor(descriptor_class, rpc_value)
    new_hash = {}
    return [rpc_value, false] if rpc_value.nil?

    return [rpc_value, true] if descriptor_class.nil?

    descriptor_class.entries.each do |entry|

      value, is_serialized =  deserialize_with_field_descriptor(entry, rpc_value[entry.name])

      if is_serialized
        new_hash[entry.name.to_sym] = value
      end
    end

    [new_hash, true]
  end


  def self.deserialize_with_field_descriptor(field_descriptor, value)

    return [value, false] if value.nil?

    return [value, true] if field_descriptor.nil?

    if field_descriptor.label == :repeated
      return deserialize_with_repeated_field(field_descriptor, value)
    end

    if field_descriptor.type == :message
      custom_encode = CUSTOM_ENCODED_TYPES[field_descriptor.subtype.msgclass]
      repeated_encode = REPEATED_ENCODED_TYPES[field_descriptor.subtype.msgclass]
      if custom_encode || repeated_encode
        return [nil, false] if value.respond_to?(:kind) && value.kind == :exclude_value
        return [field_descriptor.subtype.msgclass.decode_value(value), true]
      end
      if field_descriptor.subtype.is_a?(Google::Protobuf::Descriptor)
        return deserialize_with_descriptor(field_descriptor.subtype, value) unless value.nil?
      end

      return [value.to_h, true]

    end
    [value, true]
  end

  def self.deserialize_with_repeated_field(field_descriptor, value)

    return [value, false] if value.nil?

    if field_descriptor.label == :repeated

      if field_descriptor.subtype && field_descriptor.subtype.lookup("key")
        if field_descriptor.subtype.lookup("value")
          value_dup = ({}).dup
          org_value = value || {}
          org_value.keys.each do |k|
            field_value, is_serialized = deserialize_with_field_descriptor(field_descriptor.subtype.lookup("value"), org_value[k])
            if is_serialized
              value_dup[k.to_sym] = field_value
            end
          end
          return [value_dup, true]
        else
          return [value.to_h, true]
        end
      end

      final_value = []
      (value || []).map do |v|
        field_value, is_serialized = deserialize_with_descriptor(field_descriptor.subtype, v)
        final_value << field_value if is_serialized
      end

      return [final_value, true]
    end
  end
end
