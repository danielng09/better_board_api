JobPosting.__elasticsearch__.client = Elasticsearch::Client.new url: ENV['BONSAI_URL']

# unless JobPosting.__elasticsearch__.index_exists?
#   JobPosting.__elaticsearch__.create_index! force: true
#   JobPosting.import
# end
