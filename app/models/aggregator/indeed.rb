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
      raw_data = get_postings(params)
      extract_relevant_data(raw_data['results'])
      params[:start] = raw_data['end'] + 1
    end
    results
  end

  def old_posting?(post)
    false
  end

  def data_format
    [[:title, 'jobtitle'],
     [:company, 'company'],
     [:location, 'formattedLocation'],
     [:description, 'snippet'],
     [:url, 'url'],
     [:date_posted, Proc.new { |post| Time.parse(post['date']).strftime("%m/%d/%Y") }],
     [:source_id, 'jobkey'],
     [:source, Proc.new { |post| 'indeed' }]]
  end
end

# $in = Aggregator::Indeed.new({
#       search: 'ruby',
#       location: 'san francisco bay area',
#       activity: 1
#     })
