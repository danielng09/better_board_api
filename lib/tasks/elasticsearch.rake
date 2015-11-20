namespace :elasticsearch do
  desc "Rake task to create job posting index"
  task :create_index => :environment do
    JobPosting.__elasticsearch__.create_index! force: true
    JobPosting.import
  end

  desc "Rake task import job postings" do
    JobPosting.import
  end
end
