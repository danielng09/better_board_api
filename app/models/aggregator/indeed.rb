require 'rest-client'
require 'time'

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


class Indeed
  attr_accessor :publisher_id, :api_url, :results, :passed_params

  def initialize(passed_params)
    self.api_url = "http://api.indeed.com/ads/apisearch"
    self.passed_params = passed_params
    self.results = []
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

  def merge_params
    hash = {}
    search_param_keys.each do |actual_key, passed_key|
      hash[actual_key] = passed_params[passed_key] if passed_params[passed_key]
    end
    default_params.merge(hash)
  end

  def search
    search_params = merge_passed_params
    total_results = false
    raw_data = {'end' => 0, 'totalResults' => 1}
    until raw_data['end'] >= raw_data['totalResults']
      raw_data = get_job_listing(search_params)
      extract_relevant_data(raw_data['results'])
      search_params[:start] = raw_data['end'] + 1
    end
    self.results
  end

  def sort_results!
    self.results = self.results.sort_by do |h|
      Time.strptime(h[:date], "%m/%d/%Y")
    end.reverse
  end

  def extract_relevant_data(raw_data)
    raw_data.each do |post|
        binding.pry
      self.results.push({
        jobtitle: post['jobtitle'],
        company: post['company'],
        location: post['formattedLocation'],
        description: post['snippet'],
        url: post['url'],
        date: Time.parse(post['date']).strftime("%m/%d/%Y"),
        id: post['jobkey'],
        source: self.class.name
      })
    end
  end

  def get_job_listing(search_params)
    output = RestClient.get(self.api_url, {params: search_params})
    JSON.parse(output)
  end
end

$in = Indeed.new({
      search: 'ruby',
      location: 'san francisco bay area',
      activity: 1
    })
