module Faceberry
	class Account < Faceberry::Identity
		attr_reader :name, :access_token, :category, :id, :perms

	end

end
