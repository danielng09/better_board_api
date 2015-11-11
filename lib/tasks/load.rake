namespace :load do
  desc "Rake task to get job postings data"
  task :postings => :environment do
    puts "Previously #{JobPosting.count} job posts!"
    params = { search: 'ruby',
               location: 'san francisco bay area',
               activity: 1 }
   loader = Aggregator::Loader.new(params)
   loader.query_apis
   loader.save_results
    puts "Currently #{JobPosting.count} job posts!"
    puts "#{Time.now} - Success!"
  end
end
