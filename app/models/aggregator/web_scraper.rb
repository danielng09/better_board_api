class Aggregator::WebScraper
  def initialize(scraper, passed_params)
    self.scraper = scraper
    self.passed_params = passed_params
    self.results = []
  end
end
