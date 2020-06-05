require "will_paginate/array"

module Api
  module V1
    class IpLoginsController < ApplicationController
      def index
        authors = IpLogins::Finder.new(Array(params[:logins])).find
        paginate json: authors, status: 200
      end
    end
  end
end