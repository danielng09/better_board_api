require 'elasticsearch/rails/tasks/import'

# namespace :elasticsearch do
#   desc "Rake task to create job posting index"
#   task :create_index => :environment do
#     JobPosting.__elasticsearch__.create_index! force: true
#   end
#
#   desc "Rake task import job postings"
#   task :import => :environment do
#     JobPosting.import
#   end
# end
