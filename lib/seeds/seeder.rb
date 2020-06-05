require "parallel"
require "net/http"

module Seeds
  class Seeder
    def initialize(posts_number:, users_number:, ips_number:, processes_number:)
      @posts_number = posts_number
      @users_number = users_number
      @ips_number = ips_number
      @processes_number = processes_number
    end

    def run
      Parallel.each(@posts_number.times, in_processes: @processes_number) do |index|
        data = post(index)
        Posts::Creator.new(data).create
      end

      post_ids = Post.where("MOD(id, 123) = 0").last(1_000).pluck(:id)
      post_ids.each do |post_id|
        Parallel.each(1..@processes_number, in_processes: @processes_number) do
          data = mark(post_id)
          Marks::Updater.new(data).update
        end
      end
    end

    def run_api(url)
      Parallel.each(@posts_number.times, in_processes: @processes_number) do |index|
        data = post(index)
        uri = URI.join(url, "/api/v1/posts")
        Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.post(uri, data.to_json, "Content-Type" => "application/json")
        end
      end

      post_ids = Post.where("MOD(id, 123) = 0").last(1_000).pluck(:id)
      post_ids.each do |post_id|
        uri = URI.join(url, "/api/v1/marks/#{post_id}")
        Parallel.each(1..@processes_number, in_processes: @processes_number) do
          Net::HTTP.start(uri.hostname, uri.port) do |http|
            data = mark(post_id)
            http.put(uri, data.to_json, "Content-Type" => "application/json")
          end
        end
      end
    end

    private

    def post(index)
      {
        ip: "127.0.0.#{index % @ips_number}",
        login: "Login_#{index % @users_number}",
        header: "Header_#{index}",
        content: "Content_#{index}"
      }
    end

    def mark(post_id)
      { post_id: post_id, mark: rand(1..5) }
    end
  end
end