module IpLogins
  class Finder

    def initialize(logins)
      @logins = logins
    end

    def find
      data = @logins.map do |login|
        ActiveRecord::Base.connection.quote(login)
      end.join(", ")
      IpLogin.connection.exec_query("SELECT * FROM get_ip_logins(ARRAY[#{data}]);").to_a
    end
  end
end