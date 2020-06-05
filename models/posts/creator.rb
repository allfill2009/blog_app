module Posts
  class Creator
    attr_reader :validator, :post

    def initialize(post, validator_class: Posts::Validator)
      @post = post
      @validator = validator_class.new(post)
    end

    def create
      return self unless validator.valid?

      data = [:login, :header, :content, :ip].map do |value|
        ActiveRecord::Base.connection.quote(post[value])
      end.join(", ")
      Post.connection.execute("SELECT * FROM create_post(#{data});")

      self
    end

    def on_success
      yield unless validator.errors&.any?
    end

    def on_fail
      yield if validator.errors&.any?
    end
  end
end