class Aggregator::Indeed < Aggregator::ApiRetriever
  def initialize(passed_params)
    self.api_url = "http://api.indeed.com/ads/apisearch"
    super
  end

  def default_params
    { publisher: ENV['INDEED_API_KEY'],
      userip: '1',
      useragent: 'Chrome',
      v: '2',
      jt: 'fulltime',
      format: 'JSON',
      start: 0,
      limit: '25' }
  end

  def search_param_keys
    [[:q, :search], [:l, :location], [:fromage, :activity]]
  end

  def search
    params = merge_passed_params
    total_results = false
    raw_data = {'end' => 0, 'totalResults' => 1}
    until raw_data['end'] >= raw_data['totalResults']
      raw_data = get_job_listings(params)
      extract_relevant_data(raw_data['results'])
      params[:start] = raw_data['end'] + 1
    end
    self.results
  end

  def old_posting?(post)
    false
  end

  def data_format
    [[:jobtitle, 'jobtitle'], [:company, 'company'], [:location, 'formattedLocation'], [:description, 'snippet'], [:url, 'url'], [:date, 'date'], [:id, 'jobkey'], [:source, 'indeed']]
  end

  def get_job_listings(params)
    output = RestClient.get(self.api_url, {params: params})
    JSON.parse(output)
  end
end

# $in = Aggregator::Indeed.new({
#       search: 'ruby',
#       location: 'san francisco bay area',
#       activity: 1
#     })
