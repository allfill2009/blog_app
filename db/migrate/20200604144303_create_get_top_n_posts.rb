class CreateGetTopNPosts < ActiveRecord::Migration[6.0]
  def change
    execute(<<-SQL)
      CREATE OR REPLACE FUNCTION get_top_n_posts(INT)
      RETURNS TABLE(header VARCHAR, content VARCHAR) AS $$
      BEGIN
        RETURN QUERY SELECT p.header, p.content
        FROM posts p
        ORDER BY p.average_mark desc, p.id desc
        LIMIT $1;
      END
      $$ LANGUAGE plpgsql;
    SQL
  end
end
