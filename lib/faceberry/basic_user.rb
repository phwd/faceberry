require 'faceberry/identity'

module Faceberry
  class BasicUser < Faceberry::Identity
    attr_reader :id, :name, :first_name, :last_name, :link, :username, :gender, :locale
  end
end
