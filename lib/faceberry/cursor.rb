require 'faceberry/core_ext/kernel'

module Faceberry
  class Cursor
    include Enumerable
    attr_reader :attrs, :collection, :data, :paging
    alias to_hash attrs

    # Initializes a new Cursor object
    #
    # @param response [Hash]
    # @param collection_name [String, Symbol] The name of the method to return the collection
    # @param klass [Class] The class to instantiate object in the collection
    # @param client [Faceberry::Client]
    # @param method_name [String, Symbol]
    # @param method_options [Hash]
    # @return [Faceberry::Cursor]
    def self.from_response(response, collection_name, klass, client, id, method_name, method_options)
      new(response[:body], collection_name, klass, client, id, method_name, method_options)
    end

    # Initializes a new Cursor
    #
    # @param attrs [Hash]
    # @param collection_name [String, Symbol] The name of the method to return the collection
    # @param klass [Class] The class to instantiate object in the collection
    # @param client [Faceberry::Client]
    # @param method_name [String, Symbol]
    # @param method_options [Hash]
    # @return [Faceberry::Cursor]
    def initialize(attrs, collection_name, klass, client, id, method_name, method_options)
      @attrs = attrs
      @client = client
			@id = id
      @method_name = method_name
      @method_options = method_options
      @collection = Array(attrs[:data]).map do |item|
        if klass
          klass.fetch_or_new(item)
        else
          item
        end
      end
      class_eval do
        alias_method(:data, :collection)
      end
    end

    # @param collection [Array]
    # @param cursor [Integer]
    # @return [Array]
    def all(collection=collection, cursor=next_cursor)
			cursor = CGI.parse(URI.parse(cursor).query)
			if cursor["after"][0] 
				cursor = @client.send(@method_name.to_sym, @id.to_sym, @method_options.merge({:limit => 500, :after => cursor["after"][0]}))
				collection += cursor.collection
				cursor.last? ? collection.flatten : all(collection, cursor.next_cursor)
			elsif cursor["until"][0]
				cursor = @client.send(@method_name.to_sym, @id.to_sym, @method_options.merge({:limit => 500, :until => cursor["until"][0]}))
				collection += cursor.collection
				cursor.data.empty? ? collection.flatten : all(collection, cursor.next_cursor)
			end
    end

    # @return [Enumerable]
    def each
      all(collection, next_cursor).each do |element|
        yield element
      end
    end

    def next_cursor
      @attrs[:paging][:next] || ""
    end

    def previous_cursor
      @attrs[:paging][:previous]
    end

    # @return [Boolean]
    def first?
      previous_cursor.empty?
    end
    alias first first?

    # @return [Boolean]
    def last?
      next_cursor.empty?
    end
    alias last last?

  end
end
