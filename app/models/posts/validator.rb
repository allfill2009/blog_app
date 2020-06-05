module Posts
  class Validator
    include ActiveModel::Validations

    def initialize(post)
      @post = post
    end

    validate do
      if @post[:login].blank?
        errors.add(:login, "Post.Login is blank")
      end

      if @post[:header].blank?
        errors.add(:header, "Post.Header is blank")
      end

      if @post[:content].blank?
        errors.add(:content, "Post.Content is blank")
      end

      if @post[:ip].blank?
        errors.add(:ip, "Post.IP is blank")
      end
    end
  end
end