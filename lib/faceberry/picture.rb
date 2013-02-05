require 'faceberry/identity'

module Faceberry
	class Picture < Faceberry::Identity
		attr_reader :url, :width, :height, :is_silhouette
	end
end

