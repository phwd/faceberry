require 'faceberry/client'
require 'faceberry/configurable'

module Faceberry
  class << self
    include Faceberry::Configurable

    # Delegate to a Faceberry::Client
    #
    # @return [Faceberry::Client]
    def client
      @client = Faceberry::Client.new(options) unless defined?(@client) && @client.cache_key == options.hash
      @client
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Faceberry.setup
