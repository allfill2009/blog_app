module Marks
  class Updater
    attr_reader :average_mark, :errors

    def initialize(post)
      @post = post
    end

    def update
      data = [@post[:post_id], @post[:mark]].map(&:to_i).join(", ")
      @average_mark = Post.connection.exec_query("SELECT * FROM update_mark(#{data});").to_a&.first&.values&.first

      @errors = []
      if @average_mark.blank?
        @errors << "Post ID:#{@post[:post_id]} not found"
      end

      self
    end

    def on_success
      yield unless errors&.any?
    end

    def on_fail
      yield if errors&.any?
    end
  end
end