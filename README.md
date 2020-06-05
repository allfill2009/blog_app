# README

Test application is to create posts, give them marks, and get statistics.

Configuration:
* Ruby version: 2.7.0

* Ruby On Rails version: 6.0.3.1

* System: Ubuntu 18.04.1

* Database: PostgreSQL 10.13

* Application Server: Puma (default)

Please see Blog_app.postman_collection.json to Run the following JSON API methods:
* Add a Post: POST api/v1/posts?user_id=1&header=ABC&content=Content
* Update its Mark: PUT api/v1/marks?post_id=1&mark=5
* Get Top N Marks: GET api/v1/top_marks?top_n=100
* Get IPs and Logins: GET api/v1/ip_logins?logins[]=Login_1&logins[]=Login_0

