class CreateTaskJob
  include Sidekiq::Worker
  queue_as :default

  def perform(*args)
    Project.find_each do |p|
      Task.create(name: "New Task #{Time.zone.now}", project: p)
    end
  end
end