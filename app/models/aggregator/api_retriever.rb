module Aggregator
  class ApiRetriever
    attr_accessor :results, :passed_params, :api_url

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
        next if old_posting?(post)
        formatted_post = {}
        data_format.each do |key, name|
          if name.is_a?(String)
            formatted_post[key] = post[name]
          elsif name.is_a?(Proc)
            formatted_post[key] = name.call(post)
          end
        end
        results.push(formatted_post)
      end
    end

    def get_postings(params, xml=false)
      output = RestClient.get(api_url, {params: params})
      output = Hash.from_xml(output).to_json if xml
      JSON.parse(output)
    end
  end
end
#
# rss = RSS::Parser.parse(url , false)
# JSON.parse(rss.items.to_json)
