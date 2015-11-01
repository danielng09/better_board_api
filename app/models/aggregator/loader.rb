require 'csv'

require './indeed.rb'
require './stackoverflow.rb'
require './github.rb'

class SearchJobListing
  attr_accessor :results

  def initialize
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

  def default_params
    {
      search: 'ruby',
      location: 'san francisco bay area',
      activity: 1
    }
  end

  def query_apis(passed_params={})
    params = self.default_params.merge(passed_params)
    indeed = Indeed.new(params).search
    stackoverflow = StackOverflow.new(params).search
    github = Github.new(params).search
    self.results = indeed + stackoverflow
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

  def save_data_as_csv
    CSV.open('./data.csv', 'w') do |file|
      file << ['date_posted', 'title', 'company', 'url', 'description', 'location', 'source_id', 'source']
      self.results.each do |result|
        file << [result[:date], result[:jobtitle], result[:company], result[:url], result[:description], result[:location], result[:id], result[:source]]
      end
    end
  end
end

$search = SearchJobListing.new
$search.query_apis
$search.filter_results
$search.sort_results!
$search.save_data_as_csv
