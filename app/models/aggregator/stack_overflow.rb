# require 'active_support/core_ext/hash'

class Aggregator::StackOverflow < Aggregator::ApiRetriever
  def initialize(passed_params)
      self.api_url = 'http://careers.stackoverflow.com/jobs/feed'
      super
  end

  def default_params
    { range: 40,
      distanceUnits: 'Miles',
      sort: 'p' }
  end

  def search_param_keys
    [[:searchTerm, :search], [:location, :location]]
  end

  def search
    raw_data = get_postings(merge_passed_params, true)
    extract_relevant_data(raw_data['rss']['channel']['item'])
    results
  end

  def old_posting?(post)
    time = Time.parse(post['pubDate'])
    ((Time.now - time).to_i / 86_400) > passed_params[:activity]
  end

  def data_format
    [[:jobtitle, 'title'],
     [:company, Proc.new { |post| post['author']['name'] }],
     [:location, 'location'],
     [:description, 'description'],
     [:url, 'link'],
     [:date, Proc.new { |post| Time.parse(post['pubDate']).strftime("%m/%d/%Y") }],
     [:id, Proc.new { |post| post['link'].match(/http:\/\/careers\.stackoverflow\.com\/jobs\/(\d+)/)[1] }],
     [:source, Proc.new { |post| 'stack overflow' }]]
  end
end

$so = Aggregator::StackOverflow.new({
      search: 'ruby',
      location: 'san francisco bay area',
      activity: 1
    })
