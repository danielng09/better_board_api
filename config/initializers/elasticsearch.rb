Elasticsearch::Model.client = Elasticsearch::Client.new url: "http://localhost:9200/"

unless JobPosting.__elasticsearch__.index_exists?
  JobPosting.__elaticsearch__.create_index! force: true
  JobPosting.import
end
