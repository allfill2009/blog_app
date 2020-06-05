require "will_paginate/array"

module Api
  module V1
    class TopMarksController < ApplicationController
      def index
        top_marks = TopMarks::Finder.new(params[:top_n]).find
        paginate json: top_marks, status: 200
      end
    end
  end
end
