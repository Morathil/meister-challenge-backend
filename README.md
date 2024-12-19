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

Thoughts: Create a single project or split into two projects. (fontend / backend)

- Created new app with `rails new meister-challenge`
- `bin/rails generate model Project name:string`
- `bin/rails db:migrate`
- `bin/rails generate model Task name:string project:references`
- Add `has_many :tasks` to project model
- Tests in rails console:
    - Create project and task: `Project.create(name: 'p1')`, `Task.create(name: 't1', project_id: 1)`
    - Test relation: `Project.first.tasks`, `Task.first.project`
    - Verfied database model and relations work.
- Add graphql dependency `bundle add graphql`, `rails generate graphql:install`, `bundle install`
- `rails g graphql:object Project name:String tasks:[Task]`
- Add project resolver and types (project, task) and query field
- Test graphql query:
```
query_string = "
{
  project(id: 1) {
    id
    name
    tasks {
        name
    }
  }
}"
MeisterChallengeSchema.execute(query_string)
```
- Disable cors in config and `gem install rack-cors`
- Disable `forgery_protection_origin_check` for development
- Disable `skip_before_action :verify_authenticity_token` in graphql controller
- Refactored graphql for actual use case (all and not by id)

