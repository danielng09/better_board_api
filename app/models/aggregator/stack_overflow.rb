require 'pry'
require 'rest-client'
require 'time'
require 'nokogiri'
require 'active_support/core_ext/hash'

class StackOverflow
  attr_accessor :api_url, :results, :passed_params

  def initialize(passed_params)
      self.api_url = 'http://careers.stackoverflow.com/jobs/feed'
      self.results = []
      self.passed_params = passed_params
  end

  def default_params
    {
      range: 20,
      distanceUnits: 'Miles',
      sort: 'p'
    }
  end

  def merge_passed_params
    passed_params = {}
    passed_params[:searchTerm] = self.passed_params[:search] if self.passed_params[:search]
    passed_params[:location] = self.passed_params[:location] if self.passed_params[:location]
    passed_params[:activity] = self.passed_params[:activity] if self.passed_params[:activity]
    self.default_params.merge(passed_params)
  end

  def search
    search_params = merge_passed_params
    output = RestClient.get(self.api_url, {params: search_params})
    raw_data = JSON.parse(Hash.from_xml(output).to_json)
    extract_relevant_data(raw_data['rss']['channel']['item'])
    self.results
  end

  def extract_relevant_data(raw_data)
    raw_data.each do |post|
      time = Time.parse(post['pubDate'])
      next if ((Time.now - time).to_i / 86_400) > self.passed_params[:activity]
      self.results.push({
        jobtitle: post['title'],
        company: post['author']['name'],
        location: post['location'],
        description: post['description'],
        url: post['link'],
        date: time.strftime("%m/%d/%Y"),
        id: post['link'].match(/http:\/\/careers\.stackoverflow\.com\/jobs\/(\d+)/)[1],
        source: self.class.name
      })
    end
  end
end

$so = StackOverflow.new({
      search: 'ruby',
      location: 'san francisco bay area',
      activity: 1
    }).search
