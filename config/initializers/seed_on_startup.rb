Rails.application.config.after_initialize do
  if ActiveRecord::Base.connection.table_exists?('projects') && Project.all.empty?
    puts "Database is empty. Seeding database..."
    require Rails.root.join('db/seeds')
  end
end