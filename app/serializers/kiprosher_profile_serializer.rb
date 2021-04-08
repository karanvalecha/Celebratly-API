class KiprosherProfileSerializer
	include JSONAPI::Serializer

  attributes :id, :full_name, :doj, :dob, :email
end
  