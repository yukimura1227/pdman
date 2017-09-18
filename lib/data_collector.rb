class DataCollector
  def self.sample(default_url = '/ml1')
    if ScrapingTarget::MonsterListPage.count.zero?
      ScrapingTarget::MonsterListPage.where(url: default_url).first_or_create
    end
    ScrapingTarget::MonsterListPage.all.each(&:scraping)
  end
end
