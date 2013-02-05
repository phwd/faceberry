require 'faraday'
require 'multi_json'
require 'faceberry/api/users'
require 'faceberry/configurable'
require 'faceberry/error/client_error'
require 'simple_oauth'
require 'uri'

module Faceberry
  class Client
    include Faceberry::API::Users
    include Faceberry::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Faceberry::Client]
    def initialize(options={})
      Faceberry::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Faceberry.instance_variable_get(:"@#{key}"))
			end
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

		def post(path, params={})
			request(:post, path, params)
		end

		def delete(path, params={})
			request(:delete, path, params)
		end

  private

    def request(method, path, params={}, signature_params=params)
      params[:access_token] = params[:access_token] || Faceberry.credentials[:access_token]
			connection.send(method.to_sym, path, params) do |request|
				#request.body[:access_token] = Faceberry.credentials[:access_token]
        # request.headers[:authorization] = auth_header(method.to_sym, path, signature_params).to_s
      end.env
    rescue Faraday::Error::ClientError
      raise Faceberry::Error::ClientError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end

    def auth_header(method, path, params={})
      uri = URI(@endpoint + path)
      SimpleOAuth::Header.new(method, uri, params, credentials)
    end

  end
end
