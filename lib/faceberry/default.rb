require 'faraday'
require 'faceberry/configurable'
require 'faceberry/error/client_error'
require 'faceberry/error/server_error'
require 'faceberry/request/multipart_with_file'
require 'faceberry/response/parse_json'
require 'faceberry/response/raise_error'
require 'faceberry/version'

module Faceberry
	module Default
		ENDPOINT = 'https://graph.facebook.com' unless defined? Faceberry::Default::ENDPOINT
		CONNECTION_OPTIONS = {
			:headers => {
				:accept => 'application/json',
				:user_agent => "Faceberry Ruby Gem #{Faceberry::Version}"
			},
			:open_timeout => 5,
			:raw => true,
			:ssl => {:verify => false},
			:timeout => 10,
		} unless defined? Faceberry::Default::CONNECTION_OPTIONS
		IDENTITY_MAP = false unless defined? Faceberry::Default::IDENTITY_MAP
		MIDDLEWARE = Faraday::Builder.new do |builder|
			# Convert file uploads to Faraday::UploadIO objects
			builder.use Faceberry::Request::MultipartWithFile
			# Checks for files in the payload
			builder.use Faraday::Request::Multipart
			# Convert request params to "www-form-urlencoded"
			builder.use Faraday::Request::UrlEncoded
			# Handle 4xx server responses
			builder.use Faceberry::Response::RaiseError, Faceberry::Error::ClientError
			# Parse JSON reponse bodies using MultiJson
			builder.use Faceberry::Response::ParseJson
			# Handle 5xx server responses
			builder.use Faceberry::Response::RaiseError, Faceberry::Error::ServerError
			# Set Faraday's HTTP adapter
			builder.adapter Faraday.default_adapter
		end unless defined? Faceberry::Default::MIDDLEWARE

		class << self

			# @return [Hash]
			def options
				Hash[Faceberry::Configurable.keys.map{|key| [key, send(key)]}]
			end

			# @return [String]
			def app_key
				ENV['FACEBOOK_APP_KEY']
			end

			# @return [String]
			def app_secret
				ENV['FACEBOOK_APP_SECRET']
			end

			# @return [String]
			def access_token
				ENV['FACEBOOK_ACCESS_TOKEN']
			end

			def endpoint
				ENDPOINT
			end

			def connection_options
				CONNECTION_OPTIONS
			end

			def identity_map
				IDENTITY_MAP
			end

			def middleware
				MIDDLEWARE
			end
			
		end
	end
end

