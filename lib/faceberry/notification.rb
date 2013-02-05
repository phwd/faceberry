module Faceberry
	class Notification < Faceberry::Identity
		attr_reader :id, :from, :to, :created_time, :updated_time, :title, :link,
								:application, :unread, :object

	end

end
