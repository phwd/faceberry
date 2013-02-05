require 'faceberry/base'
require 'faceberry/error/identity_map_key_error'

module Faceberry
  class Identity < Faceberry::Base

    def self.fetch(attrs)
      return unless identity_map

      id = attrs[:id]
      if id  && object = identity_map.fetch(id)
        return object.update(attrs)
      end

      return yield if block_given?
      raise Faceberry::Error::IdentityMapKeyError, "key not found"
    end

    # Stores an object in the identity map.
    #
    # @param object [Object]
    # @return [Faceberry::Identity]
    def self.store(object)
      return object unless identity_map
      identity_map.store(object.id, object)
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing an :id key.
    # @return [Faceberry::Identity]
    def initialize(attrs={})
      super
      ##raise ArgumentError, "argument must have an :id key" unless id
    end

    # @param other [Faceberry::Identity]
    # @return [Boolean]
    def ==(other)
      super || attr_equal(:id, other) || attrs_equal(other)
    end

    # @return [Integer]
    def id
      @attrs[:id]
    end

  end
end
