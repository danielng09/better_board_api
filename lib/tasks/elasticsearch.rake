namespace :elasticsearch do
  desc "Rake task to force create index"
  task :make_index => :environment do
    JobPosting.__elaticsearch__.create_index! force: true
  end
end
