require 'faceberry/default'

module Faceberry
	module Configurable
		attr_writer :app_key, :app_secret, :access_token
		attr_accessor :endpoint, :connection_options, :identity_map, :middleware

		class << self

			def keys
				@keys ||= [
					:app_key,
					:app_secret,
					:access_token,
					:endpoint,
					:connection_options,
					:identity_map,
					:middleware,
				]
			end

		end

		def configure
			yield self
			self
		end

		def credentials?
			credentials.values.all?
		end

		def cache_key
			options.hash
		end

		def reset!
			Faceberry::Configurable.keys.each do |key|
				instance_variable_set(:"@#{key}", Faceberry::Default.options[key])
			end
			self
		end
		alias setup reset!


		def credentials
			{
				:app_key => @app_key,
				:app_secret => @app_secret,
				:access_token => @access_token,
			}
		end

		def options
			Hash[Faceberry::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
		end

	end
end
