module Faceberry
	class Message < Faceberry::Identity
		attr_reader :id, :from, :to, :message, :updated_time, :unread, :unseen

	end

end

