require 'mechanize'
require 'time'

class Craigslist
  attr_accessor :results, :scraper, :BASE_URL, :ADDRESS, :default_params

  def initialize(params={})
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
        time = Time.parse(result.search('time').first.attributes['datetime'].value)
        next if ((Time.now - time).to_i / 86_400) > 1
        date = time.strftime("%m/%d/%Y")
        link = result.search('a')[1]
        title = link.text.strip
        url = self.BASE_URL + link.attributes['href'].value
        location = result.search('span.pnr').text.strip.match(/\w+, \w+/)[0]
        posting_page = self.scraper.click(search_page.link_with(text: "#{link.text}"))
        description = posting_page.search('section#postingbody').first.to_html
        self.results << {title: title, url: url, date: date, location: location, description: description, source: 'craigslist'}
      end
    end
    self.results.uniq! { |ele| ele[:title] }
  end

end

$cl = Craigslist.new
$cl.search
