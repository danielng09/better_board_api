# file = File.join(Rails.root, 'db', 'data.csv')
# csv_text = File.read(file)
# csv = CSV.parse(csv_text, headers: true)
# csv.each do |row|
#   args = row.to_hash
#   args['date_posted'] = Time.strptime(args['date_posted'], "%m/%d/%Y")
#   JobPosting.create!(args)
# end


ruby '../app/models/aggregator/loader.rb'
p 'requiring loader file'

params = { search: 'software',
           location: 'san francisco bay area',
           activity: 1 }

$loader = Aggregator::Loader.new(params)
$loader.query_apis
$loader.save_results

p 'seeded database'
