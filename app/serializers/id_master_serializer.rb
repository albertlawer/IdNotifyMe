class IdMasterSerializer
  include JSONAPI::Serializer
  attributes :id_type_id, :name_on_id, :id_number, :reference_number, :issue_date, :first_intermidiary_expiry, :second_intermidiary_expiry, :third_intermidiary_expiry, :exipry_date, :front_image, :back_image, :status
end
