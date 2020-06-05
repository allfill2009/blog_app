module Api
  module V1
    class MarksController < ApplicationController
      def update
        data = { post_id: params[:id] || params[:post_id], mark: params[:mark] }
        updater = Marks::Updater.new(data).update

        updater.on_success do
          render json: updater.average_mark, status: 200
        end

        updater.on_fail do
          render json: { errors: updater.errors }, status: 422
        end
      end

    end
  end
end