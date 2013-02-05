require 'faceberry/identity'

module Faceberry
	class Question < Faceberry::Identity
		attr_reader :id, :from, :question, :created_time, :updated_time, :options
	end
end
