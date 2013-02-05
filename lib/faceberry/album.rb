module Faceberry
	class Album < Faceberry::Identity
		attr_reader :id, :from, :name, :description, :location,
								:link, :cover_photo, :privacy, :count,
								:type, :created_time, :updated_time, :can_upload

	end

end
