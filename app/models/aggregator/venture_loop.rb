class Aggregator::VentureLoop < Aggregator::WebScraper
  attr_accessor :results, :scraper, :BASE_URL, :ADDRESS, :default_params

  def initialize(scraper, params={})
    self.BASE_URL = 'https://www.ventureloop.com/'
    self.ADDRESS = 'https://www.ventureloop.com/ventureloop/job_search.php?'
    super
  end

  def submit_form
    scraper.get(ADDRESS) do |page|
      search_form = page.form_with()
    end
  end

  def download_html
  end

  def parse_html
  end
end

# mech = Mechanize.new
# mech.history_added = Proc.new { sleep 0.5 }
