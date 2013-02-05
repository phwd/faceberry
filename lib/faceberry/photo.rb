require 'faceberry/identity'

module Faceberry
	class Photo < Faceberry::Identity
		attr_reader :id, :from, :picture, :source, :height, :width, :images, :link, :place,
			          :icon, :created_time, :updated_time

	end
end
