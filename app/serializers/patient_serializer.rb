class PatientSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name, :last_name, :jti
end
