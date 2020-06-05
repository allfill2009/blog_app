class CreateGetIpLogins < ActiveRecord::Migration[6.0]
  def change
    execute(<<-SQL)
      CREATE OR REPLACE FUNCTION get_ip_logins(VARCHAR[])
      RETURNS TABLE(ip INET, logins VARCHAR[]) AS $$
      BEGIN
        RETURN QUERY SELECT ip_logins.ip, ARRAY_AGG(DISTINCT ip_logins.login) AS logins
        FROM ip_logins
        WHERE ip_logins.login = ANY($1)
        GROUP BY ip_logins.ip;
      END
      $$ LANGUAGE plpgsql;
    SQL
  end
end
