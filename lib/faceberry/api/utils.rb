require 'faceberry/core_ext/enumerable'
require 'faceberry/core_ext/kernel'
require 'faceberry/cursor'
require 'faceberry/user'

module Faceberry
  module API
    module Utils

      DEFAULT_CURSOR = -1

    private

      # @param klass [Class]
      # @param array [Array]
      # @return [Array]
      def collection_from_array(klass, array)
        array.map do |element|
          klass.fetch_or_new(element)
        end
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param params [Hash]
      # @param options [Hash]
      # @return [Array]
      def collection_from_response(klass, request_method, path, params={})
        collection_from_array(klass, send(request_method.to_sym, path, params)[:body][:data])
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param params [Hash]
      # @param options [Hash]
      # @return [Object]
      def object_from_response(klass, request_method, path, params={})
        response = send(request_method.to_sym, path, params)
        klass.from_response(response)
      end

			def data_from_response(klass, request_method, path, params={})
				response = send(request_method.to_sym, path, params)
				puts response.inspect
				klass.fetch_or_new(response[:body][:data])
			end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array]
      def objects_from_response(klass, request_method, path, args)
        options = extract_options!(args)
        merge_user!(options, args.pop)
        collection_from_response(klass, request_method, path, options)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array<Integer>]
      def ids_from_response(request_method, path, args)
        options = extract_options!(args)
        merge_default_cursor!(options)
        merge_user!(options, args.pop)
        cursor_from_response(:ids, nil, request_method, path, options, calling_method)
      end

      # @param collection_name [Symbol]
      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param params [Hash]
      # @param options [Hash]
      # @return [Faceberry::Cursor]
      def cursor_from_response(collection_name, klass, id, request_method, path, params={}, method_name=calling_method)
				response = send(request_method.to_sym, path, params)
        Faceberry::Cursor.from_response(response, collection_name.to_sym, klass, self, id, method_name, params)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array<Faceberry::User>]
      def users_from_response(request_method, path, args)
        options = extract_options!(args)
        merge_user!(options, args.pop || screen_name)
        collection_from_response(Faceberry::User, request_method, path, options)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array<Faceberry::User>]
      def threaded_users_from_response(request_method, path, args)
        options = extract_options!(args)
        args.flatten.threaded_map do |user|
          object_from_response(Faceberry::User, request_method, path, merge_user(options, user))
        end
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array]
      def threaded_object_from_response(klass, request_method, path, args)
        options = extract_options!(args)
        args.flatten.threaded_map do |id|
          object_from_response(klass, request_method, path, options.merge(:id => id))
        end
      end

      def handle_forbidden_error(klass, error)
        if error.message == klass::MESSAGE
          raise klass.new
        else
          raise error
        end
      end

      def merge_default_cursor!(options)
        options[:cursor] = DEFAULT_CURSOR unless options[:cursor]
      end

      def screen_name
        @screen_name ||= verify_credentials.screen_name
      end

      def extract_options!(array)
        array.last.is_a?(::Hash) ? array.pop : {}
      end

      # Take a user and merge it into the hash with the correct key
      #
      # @param hash [Hash]
      # @param user [Integer, String, Faceberry::User] A Faceberry user ID, screen_name, or object.
      # @return [Hash]
      def merge_user(hash, user, prefix=nil)
        merge_user!(hash.dup, user, prefix)
      end

      # Take a user and merge it into the hash with the correct key
      #
      # @param hash [Hash]
      # @param user [Integer, String, Faceberry::User] A Faceberry user ID, screen_name, or object.
      # @return [Hash]
      def merge_user!(hash, user, prefix=nil)
        case user
        when Integer
          hash[[prefix, "user_id"].compact.join("_").to_sym] = user
        when String
          hash[[prefix, "screen_name"].compact.join("_").to_sym] = user
        when Faceberry::User
          hash[[prefix, "user_id"].compact.join("_").to_sym] = user.id
        end
        hash
      end

      # Take a multiple users and merge them into the hash with the correct keys
      #
      # @param hash [Hash]
      # @param users [Array<Integer, String, Faceberry::User>, Set<Integer, String, Faceberry::User>] An array of Faceberry user IDs, screen_names, or objects.
      # @return [Hash]
      def merge_users(hash, users)
        merge_users!(hash.dup, users)
      end

      # Take a multiple users and merge them into the hash with the correct keys
      #
      # @param hash [Hash]
      # @param users [Array<Integer, String, Faceberry::User>, Set<Integer, String, Faceberry::User>] An array of Faceberry user IDs, screen_names, or objects.
      # @return [Hash]
      def merge_users!(hash, users)
        user_ids, screen_names = [], []
        users.flatten.each do |user|
          case user
          when Integer
            user_ids << user
          when String
            screen_names << user
          when Faceberry::User
            user_ids << user.id
          end
        end
        hash[:user_id] = user_ids.join(',') unless user_ids.empty?
        hash[:screen_name] = screen_names.join(',') unless screen_names.empty?
        hash
      end

    end
  end
end
