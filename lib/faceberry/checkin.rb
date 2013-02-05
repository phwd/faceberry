module Faceberry
	class Checkin < Faceberry::Identity
		attr_reader :id, :from, :tags, :place, :application,
								:created_time, :likes, :message,
								:comments, :type

	end

end
