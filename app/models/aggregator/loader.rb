class Aggregator::Loader
  attr_accessor :results, :passed_params
  def self.load_postings
    loader = Aggregator::Loader.new(params)
    loader.query_apis
    loader.save_results
  end

  def initialize(passed_params)
    self.passed_params = passed_params
    self.results = []
  end

  def query_apis
    indeed = Aggregator::Indeed.new(passed_params).search || []
    p 'indeed loaded'
    stackoverflow = Aggregator::StackOverflow.new(passed_params).search || []
    p 'stackoverflow loaded'
    github = Aggregator::Github.new(passed_params).search || []
    p 'github loaded'
    craigslist = Aggregator::Craigslist.new(passed_params).search || []
    p 'craigslist loaded'
    self.results = indeed + stackoverflow + github + craigslist
  end

  def save_results
    results.each do |result|
      next if JobPosting.find_by({ url: result[:url] }) || JobPosting.find_by({title: result[:title], company: result[:company], location: result[:location]})
      args = result
      args[:description] = args[:description].gsub(/<br \/>/, '')
      JobPosting.create!(args)
    end
  end
end
