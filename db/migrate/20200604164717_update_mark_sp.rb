class UpdateMarkSp < ActiveRecord::Migration[6.0]
  def change
    execute(<<-SQL)
      CREATE OR REPLACE FUNCTION update_mark(BIGINT, INT) RETURNS FLOAT AS $$
      DECLARE
        mark INT := $2;
        average_mark FLOAT;
      BEGIN
        PERFORM p.marks_sum, p.marks_count, p.average_mark
        FROM posts p WHERE p.id = $1 FOR UPDATE;

        IF mark > 5 THEN
          mark := 5;
        ELSIF mark < 1 THEN
          mark := 1;
        END IF;
		
        UPDATE posts
        SET
          marks_sum = marks_sum + mark,
          marks_count = marks_count + 1,
          average_mark = (marks_sum + mark)::float / (marks_count + 1)
        WHERE id = $1;

        SELECT p.average_mark INTO average_mark
        FROM posts p WHERE p.id = $1;

        RETURN average_mark;
      END
      $$ LANGUAGE plpgsql;
    SQL
  end
end
