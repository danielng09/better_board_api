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
class ApiRetriever

  def initialize(passed_params)
    self.passed_params = passed_params
    self.results = []
  end

  def merge_passed_params

  end


end
