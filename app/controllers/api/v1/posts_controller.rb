module Api
  module V1
    class PostsController < ApplicationController
      def create
        creator = Posts::Creator.new(params).create

        creator.on_success do
          render json: creator.post, status: 200
        end

        creator.on_fail do
          render json: { errors: creator.validator.errors }, status: 422
        end
      end

    end
  end
end