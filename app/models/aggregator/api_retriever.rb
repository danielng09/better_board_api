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
require 'time'

module Aggregator
  class ApiRetriever
    def initialize(passed_params)
      self.passed_params = passed_params
      self.results = []
    end

    def merge_passed_params
      hash = {}
      search_param_keys.each do |actual_key, passed_key|
        hash[actual_key] = passed_params[passed_key] if passed_params[passed_key]
      end
      default_params.merge(hash)
    end

    def sort_results!
      results = results.sort_by do |post|
        Time.strptime(post[:date], "%m/%d/%Y")
      end.reverse
    end

    def extract_relevant_data(raw_data)
      raw_data.each do |post|
        formatted_post = {}
        data_format.each do |key, name|
          if key == :date
            formatted_post[key] = Time.parse(post[name].strftime("%m/%d/%Y")
          else
            formatted_post[key] = post[name]
          end
        })
        self.results.push(formatted_post)
      end
    end
  end
end
