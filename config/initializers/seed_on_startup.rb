Rails.application.config.after_initialize do
  if Project.all.empty?
    puts "Database is empty. Seeding database..."
    require Rails.root.join('db/seeds')
  end
end