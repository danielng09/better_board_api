class Aggregator::Craigslist
  attr_accessor :results, :scraper, :BASE_URL, :ADDRESS, :default_params

  def initialize(params)
    self.scraper = Mechanize.new
    self.scraper.history_added = Proc.new { sleep 0.5 }
    self.BASE_URL = 'http://sfbay.craigslist.org'
    self.ADDRESS = 'http://sfbay.craigslist.org/search/sof'
    self.results = []
    self.default_params = params
  end
  def search
    self.scraper.get(self.ADDRESS) do |search_page|
      search_form = search_page.form_with(:id => 'searchform') do |search|
        search.query = 'ruby'
        search.checkbox_with(:id => 'full-time_1').value = true
      end
      result_page = search_form.submit
      raw_results = result_page.search('p.row')
      raw_results.each do |result|
        date_posted = Time.parse(result.search('time').first.attributes['datetime'].value)
        next if ((Time.now - date_posted).to_i / 86_400) > 1
        link = result.search('a')[1]
        title = link.text.strip
        url = self.BASE_URL + link.attributes['href'].value
        source_id = link.attributes['href'].value.match(/\w+\/\w+\/(.*?)\.html/)[1]
        raw_location = result.search('span.pnr').text.strip.match(/\((.*?)\)/)
        location = raw_location ? raw_location[1] : "SF Bay Area"
        posting_page = self.scraper.click(search_page.link_with(text: "#{link.text}"))
        description = posting_page.search('section#postingbody').first.to_html
        self.results << {title: title, url: url, date_posted: date_posted, location: location, description: description, source: 'craigslist', source_id: source_id, company: 'unknown'}
      end
    end
    self.results.uniq! { |ele| ele[:title] }
  end

end
params = { search: 'ruby',
           location: 'san francisco bay area',
           activity: 1 }
