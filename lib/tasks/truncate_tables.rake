# lib/tasks/truncate_tables.rake
namespace :db do
  desc 'Truncate all tables seeded by db:seed'
  task truncate: :environment do
    models_to_truncate = [Article] # Add other models as needed

    models_to_truncate.each do |model|
      model.delete_all
    end

    puts 'All seeded data has been deleted.'
  end
end
