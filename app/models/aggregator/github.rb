require 'rest-client'
require 'time'

# doesnt seem to return correct search results yet

class Github
  attr_accessor :api_url, :results, :passed_params

  def initialize(passed_params)
    self.api_url = 'https://jobs.github.com/positions.json?'
    self.passed_params = passed_params
    self.results = []
  end

  def default_params
    {
      full_time: true
    }
  end

  def merge_passed_params
    passed_params = {}
    passed_params[:search] = self.passed_params[:search] if self.passed_params[:search]
    passed_params[:location] = self.passed_params[:location] if self.passed_params[:location]
    self.default_params.merge(passed_params)
  end

  def search
    search_params = merge_passed_params
    output = RestClient.get(self.api_url, {params: search_params})
    extract_relevant_data(JSON.parse(output))
    self.results
  end

  def extract_relevant_data(raw_data)
    raw_data.each do |post|
      time = Time.parse(post['created_at'])
      next if ((Time.now - time).to_i / 86_400) > self.passed_params[:activity]
      self.results.push({
        jobtitle: post['title'],
        company: post['company'],
        location: post['location'],
        description: post['description'],
        url: post['url'],
        date: time.strftime("%m/%d/%Y"),
        id: post['id'],
        source: self.class.name
      })
    end
  end
end
