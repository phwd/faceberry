require 'faceberry/identity'

module Faceberry
	class Permission < Faceberry::Identity
		attr_reader :email, :read_friendlists, :read_insights, :read_mailbox, 
				        :read_requests, :read_stream, :xmpp_login, :ads_management,
								:create_event, :manage_friendlists, :manage_notifications,
								:user_online_presence, :friends_online_presence, :publish_checkins,
								:publish_stream, :rsvp_event, :user_about_me, :friends_about_me,
								:user_activites, :friends_activites, :user_birthday, :friends_birthday,
								:user_checkins, :friends_checkins, :user_education_history,
								:friends_education_history, :user_events, :friends_events, :user_groups,
								:friends_groups, :user_hometown, :friends_hometown, :user_interests,
								:friends_interests, :user_likes, :friends_likes, :user_location,
								:friends_location, :user_notes, :friends_notes, :user_photos, 
								:friends_photos, :user_questions, :friends_questions,
								:user_relationships, :friends_relationships, :user_relationship_details,
								:friends_relationship_details, :user_religion_politics,
								:friends_religion_politics, :user_status, :friends_status,
								:user_subscriptions, :friends_subscriptions, :user_videos,
								:friends_videos, :user_website, :friends_website, :user_work_history,
								:friends_work_history, :publish_actions, :user_games_activity,
								:friends_games_activity, :manage_pages

	end

end
