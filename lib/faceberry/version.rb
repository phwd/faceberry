module Faceberry
	class Version
		MAJOR = 4 unless defined? Faceberry::Version::MAJOR
		MINOR = 3 unless defined? Faceberry::Version::MINOR
		PATCH = 0 unless defined? Faceberry::Version::PATCH
		PRE = nil unless defined? Faceberry::Version::PRE

		class << self

			def to_s
				[MAJOR, MINOR, PATCH, PRE].compact.join('.')
			end

		end

	end
end

