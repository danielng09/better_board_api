class Aggregator::Github < Aggregator::ApiRetriever
  def initialize(passed_params)
    self.api_url = 'https://jobs.github.com/positions.json?'
    super
  end

  def default_params
    { full_time: true }
  end

  def search_param_keys
    [[:search, :search], [:location, :location]]
  end

  def search
    search_params = merge_passed_params
    output = RestClient.get(self.api_url, {params: search_params})
    extract_relevant_data(JSON.parse(output))
    self.results
  end

  def old_posting?(post)
    time = Time.parse(post['created_at'])
    ((Time.now - time).to_i / 86_400) > passed_params[:activity]
  end

  def data_format
    [[:jobtitle, 'title'], [:company, 'company'], [:location, 'location'], [:description, 'description'], [:url, 'url'], [:date, 'created_at'], [:id, 'id'], [:source, 'github']]
  end
end

# $git = Aggregator::Github.new({
#       search: 'software',
#       location: 'san francisco bay area',
#       activity: 1
#     })
