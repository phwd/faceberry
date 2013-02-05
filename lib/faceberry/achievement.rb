module Faceberry
	class Achievement < Faceberry::Identity
		attr_reader :id, :from, :created_time, :application,
								:achievement, :likes, :comments

	end
	
end
