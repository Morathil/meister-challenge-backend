if Rails.env.production? || Rails.env.development?
  Sidekiq::Cron::Job.create(
    name: 'Create Task every two minutes',    # Job name
    cron: '*/2 * * * *',                      # Cron expression for two minutes
    class: 'CreateTaskJob',                   # Job class
    queue: 'default',                         # Job queue
    description: 'This job creates a task every two minutes'
  )
end