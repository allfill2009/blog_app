class CreatePostSp < ActiveRecord::Migration[6.0]
  def change
    execute(<<-SQL)
      CREATE OR REPLACE FUNCTION create_post(VARCHAR, VARCHAR, VARCHAR, INET) RETURNS void AS $$
      BEGIN
        IF NOT EXISTS(SELECT 1 FROM users u WHERE u.login = $1) THEN
          INSERT INTO users(login)
          VALUES($1);
        END IF;
        
        INSERT INTO posts(user_id, header, content)
        SELECT u.id, $2, $3 FROM users u WHERE u.login = $1;

        IF NOT EXISTS(SELECT 1 FROM ip_logins il WHERE il.login = $1 AND il.ip = $4) THEN
          INSERT INTO ip_logins(ip, login, user_id)
          SELECT $4, $1, u.id FROM users u
          WHERE u.login = $1;
        END IF;
      END
      $$ LANGUAGE plpgsql;
    SQL
  end
end
