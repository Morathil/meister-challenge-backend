# Meister Challenge
## Start Projects
### Server
- Start redis `redis-server`
- Start server `bin/rails s`
- Start sidekiq `bundle exec sidekiq`

### Client
- Start development server `npm run dev`
- Production build: `npm run build`

## Considerations
### Single Project / Two projects
- I opted to separate the frontend and backend into two distinct projects: a standalone frontend and a Rails backend API. While Rails' asset pipeline has its advantages, it had been a while since II last used it, and setting up a separate client project was faster and more comfortable for me.
- This approach aligns with creating a Rails server designed solely as an API, enabling it to support multiple clients in the future.
- To make this setup functional, I had to enable CORS and disable verify_authenticity_token. In a production environment, these settings should be carefully reviewed and securely configured.

### Automatic UI Updates
- For real-time updates, I considered a simple polling mechanism as a quick solution. However, I chose a more elegant approach by implementing GraphQL subscriptions with ActionCable, which allowed for real-time updates without polling.
- This added complexity and took extra time since it was my first time setting up GraphQL subscriptions with Actioncable on the server side, but it was a valuable learning experience.
- On the client side, I used Apollo.js as the GraphQL library, which seamlessly integrates with ActionCable. For a use case without subscriptions, I would have opted for a more lightweight package like graphql-request.

## Client
### Core stack
- Webpack
- React
- Apollo Graphql
- Mui

### Challenge steps
- I started with a basic boilerplate setup for Webpack, React, and TypeScript, based on one of my previous projects.
- The UI components were created using MUI (Material-UI), initially with hardcoded projects and tasks for prototyping. I also implemented a Grid/List toggle.
- For state management, I kept it simple with React’s built-in state. If the project would grow in complexity, I would consider introducing a more complex solution like Redux.
- Integrated Apollo GraphQL for data fetching and added queries for:
  - GetProjects: Fetches all project data for the initial screen.
  - GetTasksByProjectId: Fetches tasks for a specific project on demand. While I could have fetched all necessary data with the GetProjects query, by adding tasks, I chose to optimize initial loading by only retrieving the data required for the first screen.
- Implemented and handled real-time updates using a GraphQL subscription for task creation events.
- Refactored the UI components by introducing components like ProjectsOverview and TopBar to improve structure and readability.

## Server
### Core gems
- Graphql
- Sidekiq /-cron
- Redis

### Challenge steps
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
- Add types (project, task) and query field
- Test graphql query in rails console: (Alternative in graphiql explorer)
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
- Add sidekiq cron job that creates a new task for each project every two minutes
- Add Graphql Subscriptions using Actioncable and Redis