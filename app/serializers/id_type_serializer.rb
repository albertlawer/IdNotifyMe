class IdTypeSerializer
  include JSONAPI::Serializer
  attributes :name, :description
end
