class Aggregator::WebScraper
  attr_accessor :scraper, :passed_params, :results

  def initialize(passed_params)
    mech = Mechanize.new
    mech.history_added = Proc.new { sleep 0.5 }
    self.scraper = mech
    self.passed_params = passed_params
    self.results = []
  end
end
