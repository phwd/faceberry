require 'faceberry/basic_user'

module Faceberry
  class User < Faceberry::BasicUser
    attr_reader :languages, :third_party_id, :installed, :timezone, :updated_time,
								:verified, :bio, :birthday, :cover, :currency, :devices,
								:education, :hometown, :interested_in, :location, :political,
								:payment_pricepoints, :favorite_athletes, :favorite_teams,
								:picture, :quotes, :relationship_status, :religion,
								:security_settings, :significant_other, :video_upload_limits,
								:website, :work
	

    def username?
      !@attrs[:username].nil?
    end

  end
end
