module Faceberry
	class Thread < Faceberry::Identity
		attr_reader :id, :snippet, :updated_time, :message_count, :unread_count, :tags,
								:participants, :former_participants, :senders, :messages

	end

end
