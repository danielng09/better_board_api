require 'mechanize'

class VentureLoop
  attr_accessor :page

  def initialize
    scraper = Mechanize.new
    scraper.history_added = Proc.new { sleep 0.5 }
    self.page = scraper.get('https://www.ventureloop.com/ventureloop/job_search.php?g=1&kword=ruby&dc=all&ldata=san%20francisco&jt=1&jc=1&jd=1&d=5&btn=1')
  end

  def searchform

  end
end
