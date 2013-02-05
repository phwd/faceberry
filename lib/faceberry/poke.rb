require 'faceberry/identity'

module Faceberry
	class Poke < Faceberry::Identity
		attr_reader :to, :from, :created_time

	end
end
