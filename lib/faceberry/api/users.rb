require 'faceberry/api/utils'
require 'faceberry/user'
require 'faceberry/account'
require 'faceberry/achievement'
require 'faceberry/activity'
require 'faceberry/album'
require 'faceberry/apprequest'
require 'faceberry/checkin'
require 'faceberry/event'
require 'faceberry/post'
require 'faceberry/friendlist'
require 'faceberry/friendrequest'
require 'faceberry/group'
require 'faceberry/link'
require 'faceberry/thread'
require 'faceberry/message'
require 'faceberry/note'
require 'faceberry/notification'
require 'faceberry/permission'
require 'faceberry/photo'
require 'faceberry/picture'
require 'faceberry/poke'
require 'faceberry/question'

module Faceberry
	module API
		module Users
			include Faceberry::API::Utils

			def me(options={})
        object_from_response(Faceberry::User, :get, "/me", options)
      end

			def user(id, options={})
				object_from_response(Faceberry::User, :get, "/#{id}", options)
			end

			def accounts(id, options={})
				collection_from_response(Faceberry::Account, :get, "/#{id}/accounts", options)
			end
			
			def achievements(id, request_method, options={})
				collection_from_response(Faceberry::Achievement, request_method, "/#{id}/achievements", options)
			end

			def activities(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/activities", options)
			end

			def albums(id, options={})
				_from_response(:get, :albums, Faceberry::Album, id, "/#{id}/albums", options)
			end

			def apprequests(id, request_method, options={})
				if request_method == :get
					collection_from_response(Faceberry::AppRequest, request_method, "/#{id}/apprequests", options)
				elsif request_method == :post
					object_from_response(Faceberry::AppRequest, request_method, "/#{id}/apprequests", options)
				elsif request_method == :delete
					object_from_response(Faceberry::AppRequest, request_method, "/#{id}", options)
				end
			end

			def books(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/books", options)
			end

			def checkins(id, options={})
				_from_response(:get, :checkins, Faceberry::Checkin, id, "/#{id}/checkins", options)
			end

			def events(id, options={})
				collection_from_response(Faceberry::Event, :get, "/#{id}/events", options)
			end

			def family(id, options={})
				collection_from_response(Faceberry::User, :get, "/#{id}/family", options)
			end
			
			def feed(id, options={})
				_from_response(:get, :feed, Faceberry::Post, id, "/#{id}/feed", options)
			end

			def friendlists(id, options={})
				_from_response(:get, :friendlists, Faceberry::FriendList, id, "/#{id}/friendlists", options)
			end

			def friendrequests(id, options={})
				_from_response(:get, :friendrequests, Faceberry::FriendRequest, id, "/#{id}/friendrequests", options)
			end

			def friends(id, options={})
				collection_from_response(Faceberry::User, :get, "/#{id}/friends", options)
			end
		
			def games(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/games", options)
			end

			def groups(id, options={})
				_from_response(:get, :groups, Faceberry::Group, id, "/#{id}/groups", options)
			end

			def home(id, options={})
				_from_response(:get, :home, Faceberry::Post, id, "/#{id}/home", options)
			end

			def inbox(id, options={})
				_from_response(:get, :inbox, Faceberry::Thread, id, "/#{id}/inbox", options)
			end

			def interests(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/interests", options)
			end

			def likes(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/likes", options)
			end

			def links(id, options={})
				_from_response(:get, :links, Faceberry::Link, id, "/#{id}/links", options)
			end

			def locations(id, options={})
				_from_response(:get, :locations, Faceberry::Location, id, "/#{id}/locations", options)
			end

			def movies(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/movies", options)
			end

			def music(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/music", options)
			end

			def mutualfriends(id1, id2, options={})
				_from_response(:get, :mutualfriends, Faceberry::User, id1, "/#{id1}/mutualfriends/#{id2}", options)
			end

			def notes(id, options={})
				_from_response(:get, :notes, Faceberry::Note, id, "/#{id}/notes", options)
			end

			def notifications(id, options={})
				_from_response(:get, :notifications, Faceberry::Notification, id, "/#{id}/notifications", options)
			end

			def outbox(id, options={})
				_from_response(:get, :outbox, Faceberry::Message, id, "/#{id}/outbox", options)
			end

			def permissions(id, options={})
				object_from_response(Faceberry::Permission, :get, "/#{id}/permissions", options)
			end
 
		  def photos(id, options={})
				_from_response(:get, :photos, Faceberry::Photo, id, "/#{id}/photos", options)
			end	

			def photosuploaded(id, options={})
				_from_response(:get, :photosuploaded, Faceberry::Photo, id, "/#{id}/photos/uploaded", options)
			end

			def picture(id, options={})
				data_from_response(Faceberry::Picture, :get, "/#{id}/picture?redirect=false", options)
			end

			def pokes(id, options={})
				_from_response(:get, :pokes, Faceberry::Poke, id, "/#{id}/pokes", options)
			end

			def posts(id, options={})
				_from_response(:get, :posts, Faceberry::Post, id, "/#{id}/posts", options)
			end

			def questions(id, options={})
				_from_response(:get, :questions, Faceberry::Question, id, "/#{id}/questions", options)
			end

			def television(id, options={})
				collection_from_response(Faceberry::Activity, :get, "/#{id}/television", options)
			end



			def _from_response(request_method, method, type, id, path, options)
				cursor_from_response(method, type, id, request_method, path, options, calling_method)
			end

		end
	end
end

