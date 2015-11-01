require 'rest-client'
require 'time'
require './api_retriever.rb'

=begin
  @api_url
  @publisher_id
  @passed_params
  @results
  #initialize
  #default_params
  #merge_passed_params
  #search
  #sort_results!
  #extract_relevant_data
  #get_job_listing
=end

class Aggregator::Indeed < Aggregator::ApiRetriever
  attr_accessor :publisher_id, :api_url, :results, :passed_params

  def initialize(passed_params)
    self.api_url = "http://api.indeed.com/ads/apisearch"
    super
  end

  def default_params
    {
      publisher: ENV['INDEED_API_KEY'],
      userip: '1',
      useragent: 'Chrome',
      v: '2',
      jt: 'fulltime',
      format: 'JSON',
      start: 0,
      limit: '25',
    }
  end

  def search_param_keys
    [[:q, :search], [:l, :location], [:fromage, :activity]]
  end

#merge_passed_params

  def search
    params = merge_passed_params
    total_results = false
    raw_data = {'end' => 0, 'totalResults' => 1}
    until raw_data['end'] >= raw_data['totalResults']
      raw_data = get_job_listings(params)
      extract_relevant_data(raw_data['results'])
      search_params[:start] = raw_data['end'] + 1
    end
    self.results
  end

#sort_results!

  def data_format
    [[:jobtitle, 'jobtitle'], [:company, 'company'], [:location, 'formattedLocation'], [:description, 'snippet'], [:url, 'url'], [:date, 'date'], [:id, 'jobkey'], [:source, self.class.name]]
  end

#extract_relevant_data

  def get_job_listings(params)
    output = RestClient.get(self.api_url, {params: params})
    JSON.parse(output)
  end
end

$in = Indeed.new({
      search: 'ruby',
      location: 'san francisco bay area',
      activity: 1
    })
