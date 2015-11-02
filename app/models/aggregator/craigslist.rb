class Aggregator::Craigslist < Aggregator::ApiRetriever
  def initialize(passed_params)
    self.api_url = 'https://sfbay.craigslist.org/search/sfc/sof?'
    super
  end

  def default_params
    { employment_type: 1,
      sort: 'date',
      format: 'rss' }
  end

  def search_param_keys
    [[:search, :search]]
  end

  def search
    raw_data = get_postings(merge_passed_params, true)
    debugger
    extract_relevant_data(raw_data)
    results
  end

  def old_posting?(post)
  end

  def data_format

  end

  # def search
  #   self.scraper.get(self.ADDRESS) do |search_page|
  #     search_form = search_page.form_with(:id => 'searchform') do |search|
  #       search.query = 'ruby'
  #       search.checkbox_with(:id => 'full-time_1').value = true
  #     end
  #     result_page = search_form.submit
  #     raw_results = result_page.search('p.row')
  #     raw_results.each do |result|
  #       time = Time.parse(result.search('time').first.attributes['datetime'].value)
  #       next if ((Time.now - time).to_i / 86_400) > 1
  #       date = time.strftime("%m/%d/%Y")
  #     end
  #   end
  #   self.results.uniq! { |ele| ele[:title] }
  # end
end

params = { search: 'software',
           location: 'san francisco bay area',
           activity: 1 }
$craigs = Aggregator::Craigslist.new(params)
