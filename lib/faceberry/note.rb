module Faceberry
	class Note < Faceberry::Identity
		attr_reader :id, :from, :subject, :message, :icon, :created_time, :updated_time

	end

end
