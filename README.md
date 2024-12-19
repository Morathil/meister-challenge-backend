# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


- Created new app with `rails new meister-challenge`
- `bin/rails generate model Project name:string`
- `bin/rails db:migrate`
- `bin/rails generate model Task name:string project:references`
- Add `has_many :tasks` to project model

