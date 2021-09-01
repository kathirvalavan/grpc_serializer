# grpc_serializer
# A simple gem for nested grpc message encoding and decoding

# Usage
`$ gem install hashugar`

```
Sample Proto file (.proto) :

      syntax = "proto3";

       package cpqgrpc.product.v1;

       message Shop {
          string name = 1;   
          repeated string items = 2
       }

       message ProductRequest {
         uint64 id = 2;
         string name = 3;
         repeated string categories = 4;
         Shop shop = 5
       }
```

### Use the generated stub class ProductRequest as follows. Do deep_symbolize_keys before sending as argument
### payload:
```json
  {
    id: 1,
    name: "Macbook"
    categories: ["accessories", "electronics"],
    shop: {
      name: "shop 1",
      items: ["item1", "item2"]  
    }
  }
```

```ruby
grpc_msg = GrpcSerializer.hash_to_grpc_object(payload, ProductRequest)
```   
### To decode to hash on client or server

```ruby
hash = GrpcSerializer.grpc_object_to_hash(grpc_msg, ProductRequest)
```   
