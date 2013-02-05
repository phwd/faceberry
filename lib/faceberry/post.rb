module Faceberry
	class Post < Faceberry::Identity
		attr_reader :id, :from, :to, :message, :message_tags, :picture, :link, :name,
			          :caption, :description, :source, :properties, :icon, :actions,
								:privacy, :type, :likes, :place, :story, :story_tags, :with_tags,
								:comments, :object_id, :application, :created_time, :updated_time, 
								:include_hidden

	end

end
