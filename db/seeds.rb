# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "benchmark"
require "seeds/seeder"

puts Benchmark.measure("Seeds") {
  Seeds::Seeder.new(
    posts_number: 200_000,
    users_number: 100,
    ips_number: 50,
    processes_number: 8
  ).run
  #).run_api("http://localhost:3000")
}