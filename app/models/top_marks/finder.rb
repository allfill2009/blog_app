module TopMarks
  class Finder
    def initialize(top_n)
      @top_n = top_n.to_i
    end

    def find
      @top_n = 1 if @top_n < 1
      Post.connection.exec_query("SELECT * FROM get_top_n_posts(#{@top_n});").to_a
    end
  end
end