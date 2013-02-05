module Faceberry
	class AppRequest < Faceberry::Identity
		attr_reader :id, :application, :to, :from, :message,
								:created_time, :type

	end

end
