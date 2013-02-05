module Faceberry
	class FriendRequest < Faceberry::Identity
		attr_reader :to, :from, :message, :created_time, :unread

	end

end
