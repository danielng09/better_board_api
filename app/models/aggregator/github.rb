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
    raw_data = get_postings(merge_passed_params)
    extract_relevant_data(raw_data)
    results
  end

  def old_posting?(post)
    time = Time.parse(post['created_at'])
    ((Time.now - time).to_i / 86_400) > passed_params[:activity]
  end

  def data_format
    [[:title, 'title'],
    [:company, 'company'],
    [:location, 'location'],
    [:description, 'description'],
    [:url, 'url'],
    [:date_posted, Proc.new { |post| Time.parse(post['created_at']).strftime("%m/%d/%Y") }],
    [:source_id, 'id'],
    [:source, Proc.new { |post| 'github' }]]
  end
end

# $git = Aggregator::Github.new({
#       search: 'software',
#       location: 'san francisco bay area',
#       activity: 1
#     })
