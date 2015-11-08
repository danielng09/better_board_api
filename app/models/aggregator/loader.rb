class Aggregator::Loader
  attr_accessor :results, :passed_params
  def self.load_postings
    params = { search: 'software',
               location: 'san francisco bay area',
               activity: 1 }
    loader = Aggregator::Loader.new(params)
    loader.query_apis
    loader.save_results
  end

  def initialize(passed_params)
    self.passed_params = passed_params
    self.results = []
  end

  def has_excluded_words?(title)
    exclude = ['sr', 'senior', 'lead', 'cloudops', 'devops', 'qa', 'director', 'ios', 'android', 'mobile', 'principal']
    !title.downcase.scan(Regexp.union(exclude)).empty?
  end

  def has_included_words?(title)
    include = ['developer', 'engineer']
    !title.downcase.scan(Regexp.union(include)).empty?
  end

  def sort_results!
    self.results = self.results.sort_by { |h| Time.strptime(h[:date], "%m/%d/%Y") }.reverse
  end

  def query_apis
    indeed = Indeed.new(passed_params).search
    stackoverflow = StackOverflow.new(passed_params).search
    github = Github.new(passed_params).search
    self.results = indeed + stackoverflow + github
  end

  def filter_results
    self.results.select! do |result|
      if has_excluded_words?(result[:jobtitle])
        false
      elsif has_included_words?(result[:jobtitle])
        true
      else
        false
      end
    end
  end

  def save_results
    results.each do |result|
      next if JobPosting.find_by({ url: result[:url] }) || JobPosting.find_by({title: result[:title], company: result[:company], location: result[:location]})
      args = result
      args[:description] = args[:description].gsub(/<br \/>/, '')
      args[:date_posted] = Time.strptime(args[:date_posted], "%m/%d/%Y")
      JobPosting.create!(args)
    end
  end

  def save_data_as_csv
    CSV.open('./data.csv', 'w') do |file|
      file << ['date_posted', 'title', 'company', 'url', 'description', 'location', 'source_id', 'source']
      self.results.each do |result|
        file << [result[:date], result[:jobtitle], result[:company], result[:url], result[:description], result[:location], result[:id], result[:source]]
      end
    end
  end
end

params = { search: 'software',
           location: 'san francisco bay area',
           activity: 1 }

$loader = Aggregator::Loader.new(params)
$loader.query_apis
$loader.save_results
