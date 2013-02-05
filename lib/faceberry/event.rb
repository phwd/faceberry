module Faceberry
	class Event < Faceberry::Identity
		attr_reader :id, :owner, :name, :description, :start_time, :end_time,
								:location, :venue, :privacy, :updated_time, :picture

	end

end

